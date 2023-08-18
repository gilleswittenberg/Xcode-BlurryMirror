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
    @State private var opacity: Double = 0
    
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
                        PhotoMenu(photoModel: photoModel)
                            .padding(.bottom)
                    }
                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.2)))
                }
            }
            .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity.animation(.easeIn(duration: 0.2))))
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
            .environmentObject(PhotoModel())
            .environmentObject(BrightnessModel())
    }
}
