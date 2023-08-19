//
//  Message.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 18/08/2023.
//

import SwiftUI

struct Message: View {
    
    var text: String
    var size: CGFloat = 18
    var weight = Font.Weight.medium
    
    var body: some View {
        Text(text)
            .font(.system(size: size, weight: .medium, design: .rounded))
            .foregroundColor(.white)
            .shadow(color: Color.accentColor, radius: 8)
    }
}

struct Message_Previews: PreviewProvider {
    static var previews: some View {
        Message(text: "Message")
    }
}
