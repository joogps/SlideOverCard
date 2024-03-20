//
//  WindowAccessor.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 19/03/24.
//

import SwiftUI

/// A view that provides access to the `UIWindow` of the `View` it is in
internal struct WindowAccessor: UIViewRepresentable {
    var callback: (UIWindow) -> ()
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let window = uiView.window {
            callback(window)
        }
    }
}
