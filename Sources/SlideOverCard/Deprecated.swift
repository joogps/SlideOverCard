//
//  Deprecated.swift
//  
//
//  Created by João Gabriel Pozzobon dos Santos on 25/04/21.
//

import SwiftUI

//@available(*, deprecated, renamed: "SlideOverCard")
//public struct SlideOverCardView<Content: View>: View {
//    var isPresented: Binding<Bool>
//    let onDismiss: (() -> Void)?
//    var options: SOCOptions
//    let content: Content
//    
//    public init(isPresented: Binding<Bool>,
//                onDismiss: (() -> Void)? = nil,
//                options: SOCOptions = [],
//                content: @escaping () -> Content) {
//        self.isPresented = isPresented
//        self.onDismiss = onDismiss
//        self.options = options
//        self.content = content()
//    }
//    
//    public init(isPresented: Binding<Bool>,
//                onDismiss: (() -> Void)? = nil,
//                dragEnabled: Binding<Bool> = .constant(true),
//                dragToDismiss: Binding<Bool> = .constant(true),
//                displayExitButton: Binding<Bool> = .constant(true),
//                content: @escaping () -> Content) {
//        self.isPresented = isPresented
//        self.onDismiss = onDismiss
//        
//        var options = SOCOptions()
//        if !dragEnabled.wrappedValue { options.insert(.disableDrag) }
//        if !dragToDismiss.wrappedValue { options.insert(.disableDragToDismiss) }
//        if !displayExitButton.wrappedValue { options.insert(.hideDismissButton) }
//        
//        self.options = options
//        
//        self.content = content()
//    }
//    
//    public var body: some View {
//        SlideOverCard(isPresented: isPresented,
//                      onDismiss: onDismiss,
//                      options: options,
//                      content: {
//            content
//        })
//    }
//}
