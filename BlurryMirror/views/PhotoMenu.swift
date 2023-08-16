//
//  PhotoMenu.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 16/08/2023.
//

import SwiftUI

struct PhotoMenu: View {
    
    var image: UIImage
    var photoModel: PhotoModel
    
    @State private var isSharePresented = false
    private let imageSaver = ImageSaver()
    
    var body: some View {
        HStack {
            Spacer()
            Icon(systemName: "photo.fill.on.rectangle.fill", label: "Save")
                .onTapGesture {
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

struct PhotoMenu_Previews: PreviewProvider {
    static var previews: some View {
        PhotoMenu(image: UIImage(), photoModel: PhotoModel())
    }
}
