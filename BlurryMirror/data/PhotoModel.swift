//
//  PhotoModel.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 16/08/2023.
//

import CoreImage

class PhotoModel: ObservableObject {
    
    @Published var image: CGImage?
    var hasImage: Bool {
        image != nil
    }
    @BoundedDouble var brightness = 0
    
    func set (_ image: CGImage) {
        self.image = image
    }
    
    func clear () {
        image = nil
    }
}