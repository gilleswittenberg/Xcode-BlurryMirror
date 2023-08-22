//
//  PhotoModel.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 16/08/2023.
//

import SwiftUI

class PhotoModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var imageSnapshot: UIImage?
    
    var hasImage: Bool { image != nil }
    var hasImageSnapshot: Bool { imageSnapshot != nil }
    var imageShareData: Data? {
        imageSnapshot?.jpegData(compressionQuality: 0.8)
    }
    
    convenience init (image: UIImage, imageSnapshot: UIImage? = nil) {
        self.init()
        self.image = image
        self.imageSnapshot = imageSnapshot
    }
    
    func createImage (from cgImage: CGImage, brightness: Double = 0) {
        guard let copy = cgImage.copy() else { return }
        image = UIImage(cgImage: copy)
        
        DispatchQueue.main.async {
            self.imageSnapshot = self.createSnapshotImage(brightness)
        }
    }
    
    func clear () {
        image = nil
        imageSnapshot = nil
    }
    
    private func createSnapshotImage (_ brightness: Double) -> UIImage? {
        guard let image = image else { return nil }
        return Image(uiImage: image)
            .brightness(brightness)
            .snapshot()
    }
}
