//
//  SettingDisplay.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 17/08/2023.
//

import SwiftUI

struct SettingDisplay: View {
    
    var iconSystemName: String
    var label: String
    
    @State private var opacity: Double = 0
    
    var body: some View {
        VStack {
            Spacer()
            Icon(
                systemName: iconSystemName,
                label: label
            ).padding(.bottom)
        }
    }
}

struct SettingDisplay_Previews: PreviewProvider {
    static var previews: some View {
        SettingDisplay(iconSystemName: "sun.max", label: "Sunny")
    }
}
