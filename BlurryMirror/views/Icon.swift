//
//  Icon.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 16/08/2023.
//

import SwiftUI

struct Icon: View {
    
    var systemName: String
    var label: String?
    
    var body: some View {
        VStack {
            Image(systemName: systemName)
                .font(.system(size: 54, weight: .light, design: .rounded))
                .foregroundColor(.white)
                .frame(width: 70, height: 70)
            if let text = label {
                Text(text)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
        }
        .shadow(color: Color.accentColor, radius: 8)
    }
}

struct Icon_Previews: PreviewProvider {
    static var previews: some View {
        Icon(systemName: "sun.max", label: "13 %")
        Icon(systemName: "square.and.arrow.up.fill", label: "Share")
    }
}
