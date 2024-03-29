//
//  View+Modifiers.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 24/04/21.
//

import SwiftUI

extension View {
    /// Present a `SlideOverCard` with a boolean binding
    public func slideOverCard<Content: View, Style: ShapeStyle>(isPresented: Binding<Bool>,
                                             onDismiss: (() -> Void)? = nil,
                                             options: SOCOptions = [],
                                             style: SOCStyle<Style> = SOCStyle(),
                                             @ViewBuilder content: @escaping () -> Content) -> some View {
        return self
            .modifier(SOCModifier(isPresented: isPresented,
                                  onDismiss: onDismiss,
                                  options: options,
                                  style: style,
                                  content: content))
    }
    
    /// Present a `SlideOverCard` with a boolean optional
    public func slideOverCard<Item: Identifiable, Content: View, Style: ShapeStyle>(item: Binding<Item?>,
                                                                 onDismiss: (() -> Void)? = nil,
                                                                 options: SOCOptions = [],
                                                                 style: SOCStyle<Style> = SOCStyle(),
                                                                 @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        let binding = Binding(get: {
            item.wrappedValue != nil
        }, set: {
            if !$0 {
                item.wrappedValue = nil
            }
        })
        
        return self
            .slideOverCard(isPresented: binding,
                           onDismiss: onDismiss,
                           options: options,
                           style: style) {
            if let item = item.wrappedValue {
                content(item)
            }
        }
    }
    
    // MARK: Deprecated
    
    @available(*, deprecated, message: "Replace option parameters with the `SOCOptions` option set.")
    public func slideOverCard<Content: View>(isPresented: Binding<Bool>,
                                             onDismiss: (() -> Void)? = nil,
                                             dragEnabled: Binding<Bool> = .constant(true),
                                             dragToDismiss: Binding<Bool> = .constant(true),
                                             displayExitButton: Binding<Bool> = .constant(true),
                                             @ViewBuilder content: @escaping () -> Content) -> some View {
        let options = SOCOptions.fromValues(disableDrag: !dragEnabled.wrappedValue,
                                            disableDragToDismiss: !dragToDismiss.wrappedValue,
                                            hideDismissButton: !displayExitButton.wrappedValue)
        
        return self
            .slideOverCard(isPresented: isPresented,
                           onDismiss: onDismiss,
                           options: options,
                           content: content)
    }
    
    @available(*, deprecated, message: "Replace option parameters with the `SOCOptions` option set.")
    public func slideOverCard<Item: Identifiable, Content: View>(item: Binding<Item?>,
                                                                 onDismiss: (() -> Void)? = nil,
                                                                 dragEnabled: Binding<Bool> = .constant(true),
                                                                 dragToDismiss: Binding<Bool> = .constant(true),
                                                                 displayExitButton: Binding<Bool> = .constant(true),
                                                                 @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        let options = SOCOptions.fromValues(disableDrag: !dragEnabled.wrappedValue,
                                            disableDragToDismiss: !dragToDismiss.wrappedValue,
                                            hideDismissButton: !displayExitButton.wrappedValue)
        
        return self
            .slideOverCard(item: item,
                           onDismiss: onDismiss,
                           options: options,
                           content: content)
    }
}
