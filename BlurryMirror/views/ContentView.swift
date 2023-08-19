//
//  ContentView.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 07/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var cameraManager = CameraManager.shared
    
    var body: some View {
        
        ZStack {
            
            if cameraManager.hasNotDeterminedAuthorizion {
                InitView()
                    .zIndex(1)
                    .transition(.opacity)
            } else {
                MainView()
            }
            
            if let error = cameraManager.error {
                ErrorView(error: error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
