//
//  ErrorView.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 09/08/2023.
//

import SwiftUI

struct ErrorView: View {
    
    var error: CameraError
    
    var body: some View {
        ZStack {
            BackgroundImageView()
            VStack {
                Spacer()
                Message(text: "Camera Error", size: 28, weight: .black)
                    .padding(.bottom, 1)
                Message(text: error.description)
                    .padding(.bottom)
            }
        }
        .onTapGesture {
            guard error.isAuthorizationError else { return }
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            guard UIApplication.shared.canOpenURL(settingsUrl) else { return }
            UIApplication.shared.open(settingsUrl)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: .deniedAuthorization)
    }
}
