//
//  CGImageExtension.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 09/08/2023.
//

import CoreImage

extension CGImage {
    
    static func create (from buffer: CVPixelBuffer) -> CGImage? {
        let context = CIContext()
        let image = CIImage(cvImageBuffer: buffer)
        return context.createCGImage(image, from: image.extent)
    }
}
