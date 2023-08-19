//
//  FrameView.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 17/08/2023.
//

import SwiftUI

struct FrameView: View {
    
    @EnvironmentObject var frameModel: FrameModel
    @EnvironmentObject var photoModel: PhotoModel
    @EnvironmentObject var brightnessModel: BrightnessModel
    
    var image: CGImage
    
    private let blurRadiusMax: CGFloat = 32
    
    var body: some View {
        let uiImage = UIImage(cgImage: image)
        Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
            .brightness(brightnessModel.brightness)
            .blur(
                radius: frameModel.faceDetected ? 0 : blurRadiusMax,
                opaque: true
            )
            .animation(.default, value: frameModel.faceDetected)
    }
}

struct FrameView_Previews: PreviewProvider {
    
    static let image = CIContext()
        .createCGImage(CIImage(color: .black), from: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 0)))
    
    
    static var previews: some View {
        FrameView(image: image!)
            .environmentObject(FrameModel())
            .environmentObject(PhotoModel())
            .environmentObject(BrightnessModel())
 
    }
}
