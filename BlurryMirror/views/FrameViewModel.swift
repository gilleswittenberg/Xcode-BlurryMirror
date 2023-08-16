//
//  FrameViewModel.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 09/08/2023.
//

import CoreImage
import UIKit
import Vision

class FrameViewModel: ObservableObject {
    
    @Published var image: CGImage?
    @Published var faceDetected = false

    init () {
        FrameManager.shared.$current
            .receive(on: RunLoop.main)
            .compactMap { buffer in
                guard let buffer = buffer else { return nil }
                return CGImage.create(from: buffer)
            }
            .map { (image: CGImage) in
                self.detectFace(image: image)
                return image
            }
            .assign(to: &$image)
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
