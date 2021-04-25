//
//  Manager.swift
//  
//
//  Created by João Gabriel Pozzobon dos Santos on 24/04/21.
//

import SwiftUI

struct SOCManager {
    static func present<Content:View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, options: SOCOptions = SOCOptions(), @ViewBuilder content: @escaping () -> Content) {
        let rootCard = SlideOverCard(isPresented: isPresented, onDismiss: {
            dismiss(isPresented: isPresented)
        }, options: options, content: content)
        
        let controller = UIHostingController(rootView: rootCard)
        controller.view.backgroundColor = .clear
        controller.modalPresentationStyle = .overFullScreen
        
        UIApplication.shared.windows.first?.rootViewController?.present(controller, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            isPresented.wrappedValue = true
        }
    }

    static func dismiss(isPresented: Binding<Bool>) {
        isPresented.wrappedValue = false
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: false)
        }
    }
}
