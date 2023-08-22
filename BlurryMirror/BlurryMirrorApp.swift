//
//  BlurryMirrorApp.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 07/08/2023.
//

import SwiftUI

@main
struct BlurryMirrorApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            
            // Uncomment (and comment out the Combine code above to create screenshots (BlurryMirrorUITestsScreenshots)
            /*
            PhotoView()
                .environmentObject(PhotoModel(image: UIImage(named: "")!, imageSnapshot: UIImage(named: "")))
                .environmentObject(BrightnessModel())
            CameraView()
                .environmentObject(FrameModel())
                .environmentObject(PhotoModel())
                .environmentObject(BrightnessModel())
            InitView()
            */
        }
    }
}
