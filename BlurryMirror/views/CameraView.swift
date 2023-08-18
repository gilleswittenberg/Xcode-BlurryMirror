//
//  CameraView.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 08/08/2023.
//

import SwiftUI

struct CameraView: View {
    
    @EnvironmentObject var frameModel: FrameModel
    @EnvironmentObject var photoModel: PhotoModel
    @EnvironmentObject var brightnessModel: BrightnessModel
    
    @State private var frameViewOpacity: Double = 0
    @State private var startBrightness: Double?
    @State private var startZoomFactor: Double?
    
    var body: some View {
        ZStack {
            if let image = frameModel.image {
                FrameView(image: image)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.6)))
            }
            
            if startBrightness != nil {
                SettingDisplay(iconSystemName: "sun.max", label: "\(brightnessModel.brightnessDisplay) %")
                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.2)))
                    .zIndex(1)
            }
            
            if startZoomFactor != nil {
                SettingDisplay(iconSystemName: "plus.magnifyingglass", label: "\( String(format: "%.1f", CameraManager.shared.zoomFactor) ) x")
                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.2)))
                    .zIndex(1)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    if startBrightness == nil {
                        startBrightness = brightnessModel.brightness
                    }
                    brightnessModel.brightness = startBrightness! - (value.translation.height / UIScreen.main.bounds.height)
                }
                .onEnded { _ in
                    startBrightness = nil
                }
        )
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    if startZoomFactor == nil {
                        startZoomFactor = CameraManager.shared.zoomFactor
                    }
                    let deceleration = 1.8
                    let divisor = value > 1 ? deceleration : 1
                    CameraManager.shared.zoomFactor = startZoomFactor! * (value / divisor)
                }
                .onEnded { _ in
                    startZoomFactor = nil
                }
        )
        .gesture(
            LongPressGesture(minimumDuration: 1)
                .onEnded { _ in
                    guard let image = frameModel.image else { return }
                    guard frameModel.faceDetected else { return }
                    photoModel.createImage(from: image, brightness: brightnessModel.brightness)
                }
        )
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
            .environmentObject(FrameModel())
            .environmentObject(PhotoModel())
            .environmentObject(BrightnessModel())
    }
}
