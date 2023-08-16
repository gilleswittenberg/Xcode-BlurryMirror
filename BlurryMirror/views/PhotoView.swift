//
//  PhotoView.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 16/08/2023.
//

import SwiftUI

struct PhotoView: View {
    
    var photoModel: PhotoModel
    
    var body: some View {
        
        if let cgImage = photoModel.image {
            
            let uiImage = UIImage(cgImage: cgImage)
            
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .brightness(photoModel.brightness)
            
            VStack {
                Spacer()
                PhotoMenu(image: uiImage, photoModel: photoModel)
                    .padding(.bottom)
            }
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photoModel: PhotoModel())
    }
}
