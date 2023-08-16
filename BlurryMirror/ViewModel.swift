//
//  ViewModel.swift
//  BlurryMirror
//
//  Created by Gilles Wittenberg on 08/08/2023.
//

import CoreImage

class ContentViewModel: ObservableObject {
    
    @Published var frame: CGImage?
    
    private let frameManager = FrameManager.shared

    init() {
        setupSubscriptions()
    }
    
    func setupSubscriptions() {
        frameManager.$current
            .receive(on: RunLoop.main)
            .compactMap { buffer in
                return CGImage.create(from: buffer)
            }
            .assign(to: &$frame)
    }
}
