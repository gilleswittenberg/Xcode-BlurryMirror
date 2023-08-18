//
//  PhotoView.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 16/08/2023.
//

import SwiftUI

struct PhotoView: View {
    
    @EnvironmentObject var photoModel: PhotoModel
    @EnvironmentObject var brightnessModel: BrightnessModel
    
    @Binding var showSavedPhotoMessage: Bool
    
    var body: some View {
        if let image = photoModel.image {
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .brightness(brightnessModel.brightness)
                    .opacity(photoModel.hasImageSnapshot ? 0.9 : 1)
                    .animation(.easeIn(duration: 4), value: photoModel.hasImageSnapshot)
                
                if photoModel.hasImageSnapshot {
                    VStack {
                        Spacer()
                        PhotoMenu(photoModel: photoModel, showSavedPhotoMessage: $showSavedPhotoMessage)
                            .padding(.bottom)
                    }
                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.2)))
                }
            }
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        photoModel.clear()
                    }
            )
            .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity.animation(.easeIn(duration: 0.2))))
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    
    @State static var showSavedPhotoMessage = false
    
    static var previews: some View {
        PhotoView(showSavedPhotoMessage: $showSavedPhotoMessage)
            .environmentObject(PhotoModel())
            .environmentObject(BrightnessModel())
    }
}
