//
//  MainView.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 17/08/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var frameModel = FrameModel()
    @StateObject private var photoModel = PhotoModel()
    @StateObject private var brightnessModel = BrightnessModel()
    
    @State private var showSavedPhotoMessage = false
    
    var body: some View {
        ZStack {
            CameraView()
            
            if photoModel.hasImage {
                PhotoView(showSavedPhotoMessage: $showSavedPhotoMessage)
                    .zIndex(1) // Fix for transition bug in ZStacks (https://sarunw.com/posts/how-to-fix-zstack-transition-animation-in-swiftui/)
            }
            
            if showSavedPhotoMessage {
                VStack {
                    Spacer()
                    Message(text: "Added to Photos")
                        .padding(.bottom)
                }
                .zIndex(1)
                .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.2)))
                .flash(duration: 2, show: $showSavedPhotoMessage)
            }
        }
        .environmentObject(frameModel)
        .environmentObject(photoModel)
        .environmentObject(brightnessModel)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
