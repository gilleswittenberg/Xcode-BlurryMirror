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
        Text(error.description)
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(20)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: .deniedAuthorization)
    }
}
