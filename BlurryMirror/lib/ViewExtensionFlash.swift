//
//  ViewExtensionFlash.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 18/08/2023.
//

import SwiftUI

struct Flash: ViewModifier {
    
    @Binding var show: Bool
    let duration: Double
    
    init (duration: Double, show: Binding<Bool>) {
        self.duration = duration
        self._show = show
    }

    func body(content: Content) -> some View {
        content
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    self.show = false
                }
            }
    }
}

extension View {
    func flash(duration: Double, show: Binding<Bool>) -> some View {
        modifier(Flash(duration: duration, show: show))
    }
}
