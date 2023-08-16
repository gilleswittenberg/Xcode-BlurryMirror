//
//  FrameManager.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 08/08/2023.
//

import AVFoundation

class FrameManager: NSObject, ObservableObject {
    
    @Published var current: CVPixelBuffer?
    
    static let shared = FrameManager()
    
    private let queue = DispatchQueue(
        label: "com.gilleswittenberg.BlurryMirror.FrameManager.queue",
        qos: .userInitiated,
        attributes: [],
        autoreleaseFrequency: .workItem
    )
    
    private override init() {
        super.init()
        CameraManager.shared.set(self, queue: queue)
    }
}

extension FrameManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let buffer = sampleBuffer.imageBuffer else { return }
        DispatchQueue.main.async {
            self.current = buffer
        }
    }
}
