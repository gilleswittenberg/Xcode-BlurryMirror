//
//  FrameView.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 08/08/2023.
//

import SwiftUI

struct FrameView: View {
    
    @StateObject private var model = FrameViewModel()
    @StateObject private var photoModel = PhotoModel()
    @State private var startBrightness: Double?
    @State private var startZoomFactor: Double?
    
    private let blurRadiusMax: CGFloat = 32
    
    var body: some View {
        
        ZStack {
            
            if let image = model.image {
                let uiImage = UIImage(cgImage: image)
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .blur(
                        radius: model.faceDetected ? 0 : blurRadiusMax,
                        opaque: true
                    )
                    .brightness(photoModel.brightness)
                    .animation(.default, value: model.faceDetected)
            }
            
            
            if startBrightness != nil {
                VStack {
                    Spacer()
                    Icon(
                        systemName: "sun.max",
                        label: "\( Int(photoModel.brightness * 100) ) %"
                    ).padding(.bottom)
                }
            }
            
            if startZoomFactor != nil {
                VStack {
                    Spacer()
                    Icon(
                        systemName: "plus.magnifyingglass",
                        label: "\( String(format: "%.1f", CameraManager.shared.zoomFactor) ) x"
                    ).padding(.bottom)
                }
            }
            
            if photoModel.hasImage {
                PhotoView(photoModel: photoModel)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    if startBrightness == nil {
                        startBrightness = photoModel.brightness
                    }
                    photoModel.brightness = startBrightness! - (value.translation.height / UIScreen.main.bounds.height)
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
                    guard let image = model.image else { return }
                    photoModel.set(image)
                }
        )
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}
