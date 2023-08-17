//
//  PhotoModel.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 16/08/2023.
//

import SwiftUI

class PhotoModel: ObservableObject {
    
    @Published var image: UIImage?
    var hasImage: Bool {
        image != nil
    }
    @BoundedDouble var brightness = 0
    
    init() {}
    init (image: UIImage) {
        self.image = image
    }
    
    func createImage (from cgImage: CGImage) {
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
            .brightness(brightness)
            .snapshot()
    }
    
    func clear () {
        image = nil
    }
}
