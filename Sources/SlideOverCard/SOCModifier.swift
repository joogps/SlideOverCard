//
//  SOCModifier.swift
//  
//
//  Created by João Gabriel Pozzobon dos Santos on 18/03/24.
//

import SwiftUI
import Combine

/// A view modifier that presents a `SlideOverCard` over a `View`'s hierarchy through a `SOCManager` based on a `Binding` value
internal struct SOCModifier<ViewContent: View, Style: ShapeStyle>: ViewModifier {
    var model: SOCModel
    @Binding var isPresented: Bool
    
    private let manager: SOCManager<ViewContent, Style>
    
    @Environment(\.colorScheme) var colorScheme
    
    init(isPresented: Binding<Bool>,
                onDismiss: (() -> Void)? = nil,
                options: SOCOptions,
                style: SOCStyle<Style>,
                @ViewBuilder content: @escaping () -> ViewContent) {
        let model = SOCModel()
        self.model = model
        self._isPresented = isPresented
        
        self.manager = .init(model: model,
                             onDismiss: onDismiss,
                             options: options,
                             style: style,
                             content: content)
    }
    
    func body(content: Content) -> some View {
        content
            .onReceive(Just(colorScheme)) { value in
                manager.set(colorScheme: value)
            }
            .onReceive(model.$showCard.receive(on: RunLoop.main)) { value in
                isPresented = value
            }
            .onReceive(Just(isPresented)) { value in
                if value {
                    manager.present()
                } else {
                    manager.dismiss()
                }
            }
            .background(windowAccessor)
    }
    
    var windowAccessor: some View {
        WindowAccessor { window in
            manager.set(window: window)
        }
        .allowsHitTesting(false)
    }
}
