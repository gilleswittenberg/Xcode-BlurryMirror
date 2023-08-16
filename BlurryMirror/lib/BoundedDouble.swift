//
//  BoundedDouble.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 14/08/2023.
//

import Foundation

@propertyWrapper
struct BoundedDouble {
    
    private let defaultMin: Double = 0
    private let defaultMax: Double = 1
    
    private var min: Double
    private var max: Double
    private var value: Double
    
    var wrappedValue: Double {
        get {
            return value
        }
        set {
            if newValue < min {
                value = min
            } else if newValue > max {
                value = max
            } else {
                value = newValue
            }
        }
    }
    
    init () {
        min = defaultMin
        max = defaultMax
        value = min
    }
    
    init (wrappedValue: Double) {
        min = defaultMin
        max = defaultMax
        value = wrappedValue
    }
    
    init (wrappedValue: Double, min: Double, max: Double) {
        self.min = min
        self.max = max
        value = wrappedValue
    }
}
