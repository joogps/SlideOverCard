//
//  SlideOverCard.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 30/10/20.
//

import SwiftUI

/// A view that presents a card that slides over from the bottom of the screen
public struct SlideOverCard<Content: View, Style: ShapeStyle>: View {
    var isPresented: Binding<Bool>
    let onDismiss: (() -> Void)?
    var options: SOCOptions
    let style: SOCStyle<Style>
    let content: Content
    
    public init(isPresented: Binding<Bool>,
                onDismiss: (() -> Void)? = nil,
                options: SOCOptions = [],
                style: SOCStyle<Style> = SOCStyle(),
                content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.onDismiss = onDismiss
        self.options = options
        self.style = style
        self.content = content()
    }
    
    @GestureState private var viewOffset: CGFloat = 0.0
    
    var isiPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public var body: some View {
        ZStack {
            if isPresented.wrappedValue {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .zIndex(1)
                
                Group {
                    if #available(iOS 14.0, *) {
                        container
                            .ignoresSafeArea(.container, edges: .bottom)
                    } else {
                        container
                            .edgesIgnoringSafeArea(.bottom)
                    }
                }.transition(isiPad ? .opacity.combined(with: .offset(x: 0, y: 200)) : .move(edge: .bottom))
                    .zIndex(2)
            }
        }.animation(.spring(response: 0.35, dampingFraction: 1))
    }
    
    private var container: some View {
        VStack {
            Spacer()
            
            if isiPad {
                card.aspectRatio(1.0, contentMode: .fit)
                Spacer()
            } else {
                card
            }
        }
    }
    
    private var cardShape: some Shape {
        RoundedRectangle(cornerSize: style.cornerSize, style: .continuous)
    }
    
    private var card: some View {
        VStack(alignment: .trailing, spacing: 0) {
            if !options.contains(.hideDismissButton) {
                Button(action: dismiss) {
                    SOCDismissButton()
                }.frame(width: 24, height: 24)
            }
            
            HStack {
                Spacer()
                content
                    .padding([.horizontal, options.contains(.hideDismissButton) ? .vertical : .bottom], 14)
                Spacer()
            }
        }.padding(style.innerPadding)
        .background(cardShape.fill(style.style))
        .clipShape(cardShape)
        .offset(x: 0, y: viewOffset/pow(2, abs(viewOffset)/500+1))
        .padding(style.outerPadding)
        .gesture(
            options.contains(.disableDrag) ? nil :
                DragGesture()
                .updating($viewOffset) { value, state, transaction in
                    state = value.translation.height
                }
                .onEnded() { value in
                    if value.predictedEndTranslation.height > 175 && !options.contains(.disableDragToDismiss) {
                        dismiss()
                    }
                }
        )
        
    }
    
    func dismiss() {
        if let onDismiss {
            onDismiss()
        }
        withAnimation {
            isPresented.wrappedValue = false
        }
    }
}

extension SlideOverCard where Style == Color {
    public init(isPresented: Binding<Bool>,
                onDismiss: (() -> Void)? = nil,
                options: SOCOptions = [],
                content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.onDismiss = onDismiss
        self.options = options
        self.style = SOCStyle()
        self.content = content()
    }
}

/// A struct thtat defines the style of a `SlideOverCard`
public struct SOCStyle<S: ShapeStyle> {
    /// Initialize a style with a single value for corner radius
    public init(corners: CGFloat = 38.5,
                continuous: Bool = true,
                innerPadding: CGFloat = 20.0,
                outerPadding: CGFloat = 6.0,
                style: S = Color(.systemGray6)) {
        self.init(corners: CGSize(width: corners, height: corners),
                  continuous: continuous,
                  innerPadding: innerPadding,
                  outerPadding: outerPadding,
                  style: style)
    }
    
    /// Initialize a style with a custom corner size
    public init(corners: CGSize,
                continuous: Bool = true,
                innerPadding: CGFloat = 20.0,
                outerPadding: CGFloat = 6.0,
                  style: S = Color(.systemGray6)) {
        self.cornerSize = corners
        self.continuous = continuous
        self.innerPadding = innerPadding
        self.outerPadding = outerPadding
        self.style = style
    }
    
    let cornerSize: CGSize
    let continuous: Bool
    
    let innerPadding: CGFloat
    let outerPadding: CGFloat
    
    let style: S
}

/// A structure that defines interaction options of a `SlideOverCard`
public struct SOCOptions: OptionSet {
    public let rawValue: Int8
    
    public init(rawValue: Int8) {
        self.rawValue = rawValue
    }
    
    /// Disable dragging of the card completely, keeping it static
    public static let disableDrag = SOCOptions(rawValue: 1)
    /// Disable the ability of dismissing the card by dragging it down
    public static let disableDragToDismiss = SOCOptions(rawValue: 1 << 1)
    /// Hide the default dismiss button
    public static let hideDismissButton = SOCOptions(rawValue: 1 << 2)
}
