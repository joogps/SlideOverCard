//
//  Modifiers.swift
//  
//
//  Created by João Gabriel Pozzobon dos Santos on 24/04/21.
//

import SwiftUI

extension View {
    public func slideOverCard<Content: View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, options: SOCOptions = [], @ViewBuilder content: @escaping () -> Content) -> some View {
        return ZStack {
            self
            SlideOverCard(isPresented: isPresented,
                          onDismiss: onDismiss,
                          options: options) {
                content()
            }
        }
    }
    
    public func slideOverCard<Item: Identifiable, Content: View>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, options: SOCOptions = [], @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        let binding = Binding(get: { item.wrappedValue != nil }, set: { if !$0 { item.wrappedValue = nil } })
        return self.slideOverCard(isPresented: binding, onDismiss: onDismiss, options: options, content: {
            if let item = item.wrappedValue {
                content(item)
            }
        })
    }
    
    @available(*, deprecated, message: "Replace option parameters with the new option set.")
    public func slideOverCard<Content: View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, dragEnabled: Binding<Bool> = .constant(true), dragToDismiss: Binding<Bool> = .constant(true), displayExitButton: Binding<Bool> = .constant(true), @ViewBuilder content: @escaping () -> Content) -> some View {
        var options = SOCOptions()
        if !dragEnabled.wrappedValue { options.insert(.disableDrag) }
        if !dragToDismiss.wrappedValue { options.insert(.disableDragToDismiss) }
        if !displayExitButton.wrappedValue { options.insert(.hideExitButton) }
        
        return ZStack {
            self
            SlideOverCard(isPresented: isPresented,
                          onDismiss: onDismiss,
                          options: options) {
                content()
            }
        }
    }
    
    @available(*, deprecated, message: "Replace option parameters with the new option set.")
    public func slideOverCard<Item: Identifiable, Content: View>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, dragEnabled: Binding<Bool> = .constant(true), dragToDismiss: Binding<Bool> = .constant(true), displayExitButton: Binding<Bool> = .constant(true), @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        let binding = Binding(get: { item.wrappedValue != nil }, set: { if !$0 { item.wrappedValue = nil } })
        return self.slideOverCard(isPresented: binding, onDismiss: onDismiss, dragEnabled: dragEnabled, dragToDismiss: dragToDismiss, displayExitButton: displayExitButton, content: {
            if let item = item.wrappedValue {
                content(item)
            }
        })
    }
}
