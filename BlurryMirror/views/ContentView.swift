//
//  ContentView.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 07/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var opacity: Double = 0
    
    let error = CameraManager.shared.error
    
    var body: some View {
        ZStack {
            FrameView()
                .opacity(opacity)
                .onAppear(perform: {
                    withAnimation {
                        opacity = 1
                    }
                })
            
            if let error = error {
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
