//
//  Manager.swift
//  
//
//  Created by João Gabriel Pozzobon dos Santos on 24/04/21.
//

import SwiftUI
import Combine

/// Present a `SlideOverCard` from anywhere in your app
internal class SOCManager<Content: View, Style: ShapeStyle>: ObservableObject {
    @ObservedObject var model: SOCModel
    
    internal var cardController: UIHostingController<SlideOverCard<Content, Style>>?
    
    var onDismiss: (() -> Void)?
    var content: () -> Content
    
    private var cancellables = Set<AnyCancellable>()
    
    init(model: SOCModel,
        onDismiss: (() -> Void)?,
         options: SOCOptions,
         style: SOCStyle<Style>,
         @ViewBuilder content: @escaping () -> Content) {
        self.onDismiss = onDismiss
        self.content = content
        
        self.model = model
        let rootCard = SlideOverCard(model: _model,
                                     options: options,
                                     style: style,
                                     content: content)
        
        cardController = UIHostingController(rootView: rootCard)
        cardController?.view.backgroundColor = .clear
        cardController?.modalPresentationStyle = .overFullScreen
        
        model.$showCard
            .removeDuplicates()
            .sink { [weak self] value in
                if value {
                    self?.present()
                } else {
                    self?.dismiss()
                }
            }
            .store(in: &cancellables)
    }
    
    @available(iOSApplicationExtension, unavailable)
    public func present() {
        if let cardController, let rootViewController = UIApplication.shared.windows.first?.rootViewController {
            if rootViewController.presentedViewController == nil {
                rootViewController.present(cardController, animated: false) {
                    self.model.showCard = true
                }
            }
        }
    }
    
    /// Dismiss a `SlideOverCard`
    @available(iOSApplicationExtension, unavailable)
    public func dismiss() {
        onDismiss?()
        self.model.showCard = false
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) { [weak self] in
            self?.cardController?.dismiss(animated: false)
        }
    }
    
    public func set(colorScheme: ColorScheme) {
        cardController?.overrideUserInterfaceStyle = colorScheme.uiKit
    }
    
    public func setBlurBehindCard() {
        if let presentingViewController = cardController?.presentingViewController {
            let blurView = UIVisualEffectView()
            blurView.frame = presentingViewController.view.bounds
            presentingViewController.view.insertSubview(blurView, belowSubview: cardController!.view)
        }
    }
}

public class SOCModel: ObservableObject {
    @Published var showCard: Bool = false
}

extension ColorScheme {
    var uiKit: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
