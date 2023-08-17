//
//  PhotoMenu.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 16/08/2023.
//

import SwiftUI

struct PhotoMenu: View {
    
    var photoModel: PhotoModel
    
    @State private var isSharePresented = false
    
    var body: some View {
        if let image = photoModel.image {
            HStack {
                Spacer()
                Icon(systemName: "photo.fill.on.rectangle.fill", label: "Save")
                    .onTapGesture {
                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = {
                            photoModel.clear()
                        }
                        imageSaver.writeToPhotoAlbum(image: image)
                    }
                Spacer()
                Icon(systemName: "square.and.arrow.up.fill", label: "Share")
                    .onTapGesture {
                        isSharePresented = true
                    }
                    .sheet(isPresented: $isSharePresented) {
                        ActivityViewController(activityItems: [image])
                    }
                Spacer()
                Icon(systemName: "xmark.square.fill", label: "Clear")
                    .onTapGesture {
                        photoModel.clear()
                    }
                Spacer()
            }
        }
    }
}

struct PhotoMenu_Previews: PreviewProvider {
    static let photoModel = PhotoModel(image: UIImage())
    
    static var previews: some View {
        PhotoMenu(photoModel: photoModel)
    }
}
