//
//  InitView.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 19/08/2023.
//

import SwiftUI

struct InitView: View {
    
    private let action = {
        CameraManager.shared.configure()
    }
    
    var body: some View {
        ZStack {
            BackgroundImageView(brightness: 0.12)
            VStack {
                Spacer()
                Message(text: "Please Grant Camera Access")
                    .padding(.bottom)
            }
        }
        .onTapGesture {
            action()
        }
    }
}

struct InitView_Previews: PreviewProvider {
    static var previews: some View {
        InitView()
    }
}
