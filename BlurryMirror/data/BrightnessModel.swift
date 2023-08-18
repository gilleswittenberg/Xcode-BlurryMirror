//
//  BrightnessModel.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 17/08/2023.
//

import Foundation

class BrightnessModel: ObservableObject {
    
    @BoundedDouble var brightness = 0
    
    var brightnessDisplay: String {
        "\( Int(brightness * 100) )"
    }
}
