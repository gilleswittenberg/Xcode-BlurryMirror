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
        
        if let image = photoModel.image {
            
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                PhotoMenu(photoModel: photoModel)
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
