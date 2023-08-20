//
//  CameraManager.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 08/08/2023.
//

import AVFoundation

enum Status {
    case configured
    case failed
    case unauthorized
    case unconfigured
}

enum CameraError {
    case cameraUnavailable
    case cannotAddInput
    case cannotAddOutput
    case cannotCreateConnection
    case createCaptureInput (Error)
    case deniedAuthorization
    case restrictedAuthorization
    case unknownAuthorization
    
    var description: String {
        switch self {
        case .cameraUnavailable: return "Camera Unavailable"
        case .cannotAddInput: return "Can Not Add Input"
        case .cannotAddOutput: return "Can Not Add Output"
        case .cannotCreateConnection: return "Can Not Create Connection"
        case .createCaptureInput (let error): return error.localizedDescription
        case .deniedAuthorization: return "Authorization Denied"
        case .restrictedAuthorization: return "Authorization Restricted"
        case .unknownAuthorization: return "Authorization Unknown"
        }
    }
    
    var isAuthorizationError: Bool {
        switch self {
        case .deniedAuthorization, .restrictedAuthorization, .unknownAuthorization: return true
        default: return false
        }
    }
}

class CameraManager: ObservableObject {

    @Published var error: CameraError?
    @Published var hasNotDeterminedAuthorizion: Bool
    
    private var minZoomFactor: Double?
    private var maxZoomFactor: Double?
    private var zoomFactorValue: Double? {
        didSet {
            guard let device = device else { return }
            guard let _ = try? device.lockForConfiguration() else { return }
            defer {
                device.unlockForConfiguration()
            }
            device.videoZoomFactor = zoomFactor
        }
    }
    var zoomFactor: Double {
        get {
            guard let value = zoomFactorValue else { return 1 }
            return value
        }
        set {
            guard let minZoomFactor = minZoomFactor, let maxZoomFactor = maxZoomFactor else {
                zoomFactorValue = newValue
                return
            }
            if newValue < minZoomFactor {
                zoomFactorValue = minZoomFactor
            } else if newValue > maxZoomFactor {
                zoomFactorValue = maxZoomFactor
            } else {
                zoomFactorValue = newValue
            }
        }
    }
    
    static let shared = CameraManager()
    
    private var status = Status.unconfigured {
        didSet {
            hasNotDeterminedAuthorizion = AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined
        }
    }
    private var device: AVCaptureDevice?
    private let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "com.gilleswittenberg.BlurryMirror.CameraManager")
    private let videoOutput = AVCaptureVideoDataOutput()
    
    private init() {
        hasNotDeterminedAuthorizion = AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined
        if hasNotDeterminedAuthorizion == false {
            configure()
        }
    }

    func configure() {
        checkPermissions()
        sessionQueue.async {
            self.configureCaptureSession()
            self.session.startRunning()
        }
    }
    
    private func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: .video) { authorized in
                if authorized == false {
                    self.status = .unauthorized
                    self.error = .deniedAuthorization
                }
                self.sessionQueue.resume()
            }
        case .restricted:
            status = .unauthorized
            self.error = .restrictedAuthorization
        case .denied:
            status = .unauthorized
            self.error = .deniedAuthorization
        case .authorized:
            break
        @unknown default:
            status = .unauthorized
            self.error = .unknownAuthorization
        }
    }
    
    private func configureCaptureSession() {
        
        func abort (_ status: Status, _ error: CameraError) {
            self.status = status
            self.error = error
        }
        
        guard status == .unconfigured else { return }
        
        session.beginConfiguration()
        defer {
            session.commitConfiguration()
        }
        
        device = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .front)
        guard let device = device else {
            return abort(.failed, .cameraUnavailable)
        }
        minZoomFactor = device.minAvailableVideoZoomFactor
        maxZoomFactor = device.maxAvailableVideoZoomFactor
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input) else {
                return abort(.failed, .cannotAddInput)
            }
            session.addInput(input)
        } catch {
            return abort(.failed, .createCaptureInput(error))
        }
        
        guard session.canAddOutput(videoOutput) else {
            return abort(.failed, .cannotAddOutput)
        }
        session.addOutput(videoOutput)
        videoOutput.videoSettings = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
        ]
        
        guard let connection = videoOutput.connection(with: .video) else {
            return abort(.failed, .cannotCreateConnection)
        }
        connection.videoOrientation = .portrait
        connection.isVideoMirrored = true
        
        status = .configured
    }
    
    func set(
        _ delegate: AVCaptureVideoDataOutputSampleBufferDelegate,
        queue: DispatchQueue
    ) {
        sessionQueue.async {
            self.videoOutput.setSampleBufferDelegate(delegate, queue: queue)
        }
    }
}
