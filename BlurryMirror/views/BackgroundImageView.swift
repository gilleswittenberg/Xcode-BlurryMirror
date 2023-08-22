//
//  BackgroundImageView.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 19/08/2023.
//

import SwiftUI

struct BackgroundImageView: View {
    
    var brightness: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .blur(
                    radius: 28,
                    opaque: true
                )
                .brightness(brightness)
        }
    }
}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
    }
}
