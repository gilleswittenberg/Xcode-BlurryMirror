//
//  FrameModel.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 09/08/2023.
//

import CoreImage
import UIKit
import Vision

class FrameModel: ObservableObject {
    
    @Published var image: CGImage?
    @Published var faceDetected = false
    
    var hasImage: Bool {
        image != nil
    }

    init () {
        FrameManager.shared.$current
            .receive(on: RunLoop.main)
            .compactMap { buffer in
                guard let buffer = buffer else { return nil }
                return CGImage.create(from: buffer)
            }
            .map { (image: CGImage) in
                DispatchQueue.global().async {
                    self.detectFace(image: image)
                }
                return image
            }
            .assign(to: &$image)
        
        
        // Uncomment (and comment out the Combine code above to create screenshots (BlurryMirrorUITestsScreenshots)
        /*
        guard let uiImage = UIImage(named: "") else { return }
        guard let ciImage = CIImage(image: uiImage) else { return }
        let context = CIContext(options: nil)
        image = context.createCGImage(ciImage, from: ciImage.extent)
        faceDetected = true
        */
    }
    
    private func detectFace (image: CGImage) {
        
        func completionHandler (request: VNRequest, error: Error?) {
            guard error == nil, let results = request.results else {
                if error != nil {
                    debugPrint(error as Any)
                }
                DispatchQueue.main.async {
                    self.faceDetected = false
                }
                return
            }
            DispatchQueue.main.async {
                self.faceDetected = results.isEmpty == false
            }
        }
        
        let handler = VNImageRequestHandler(cgImage: image)
        let request = VNDetectFaceCaptureQualityRequest(completionHandler: completionHandler)
        do {
            try handler.perform([request])
        } catch let error {
            debugPrint(error)
        }
    }
}
