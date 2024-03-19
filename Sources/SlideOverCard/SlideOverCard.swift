//
//  SlideOverCard.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 30/10/20.
//

import SwiftUI

/// A view that displays a card that slides over from the bottom of the screen
@available(*, deprecated, message: "Use the 'slideOverCard(_:)' modifier instead.")
internal struct SlideOverCard<Content: View, Style: ShapeStyle>: View {
    @ObservedObject var model: SOCModel
    
    var options: SOCOptions
    let style: SOCStyle<Style>
    let content: Content
    
    init(model: ObservedObject<SOCModel>,
                options: SOCOptions = [],
                style: SOCStyle<Style> = SOCStyle(),
                content: @escaping () -> Content) {
        self._model = model
        self.options = options
        self.style = style
        self.content = content()
    }
    
    @State private var viewOffset: CGFloat = 0.0
    
    private var isiPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public var body: some View {
        ZStack {
            if model.showCard {
                Color.black
                    .opacity(style.dimmingOpacity)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .zIndex(1)
            }
                
            if model.showCard {
                Group {
                    if #available(iOS 14.0, *) {
                        container
                            .ignoresSafeArea(.container, edges: .bottom)
                    } else {
                        container
                            .edgesIgnoringSafeArea(.bottom)
                    }
                }
                .transition(isiPad ? .opacity.combined(with: .offset(x: 0, y: 200)) : .move(edge: .bottom))
                .zIndex(2)
                .onAppear {
                    viewOffset = 0
                }
            }
        }
        .animation(.defaultSpring, value: model.showCard)
    }
    
    private var container: some View {
        VStack {
            Spacer()
            
            if isiPad {
                card
                    .aspectRatio(1.0, contentMode: .fit)
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
                }
                .frame(width: 24, height: 24)
            }
            
            HStack {
                Spacer()
                content
                    .padding([.horizontal, options.contains(.hideDismissButton) ? .vertical : .bottom], 14)
                Spacer()
            }
        }
        .padding(style.innerPadding)
        .background(Rectangle().fill(style.style))
        .clipShape(cardShape)
        .offset(x: 0, y: viewOffset/pow(2, abs(viewOffset)/500+1))
        .padding(style.outerPadding)
        .gesture(
            options.contains(.disableDrag) ? nil :
                DragGesture()
                    .onChanged { value in
                        viewOffset = value.translation.height
                    }
                    .onEnded { value in
                        if value.predictedEndTranslation.height > 175 && !options.contains(.disableDragToDismiss) {
                            dismiss()
                        } else {
                            withAnimation(.defaultSpring) {
                                viewOffset = 0
                            }
                        }
                    }
        )
    }
    
    func dismiss() {
        model.showCard = false
    }
}

extension SlideOverCard where Style == Color {
    internal init(model: ObservedObject<SOCModel>,
                options: SOCOptions = [],
                content: @escaping () -> Content) {
        self._model = model
        self.options = options
        self.style = SOCStyle()
        self.content = content()
    }
}

extension Animation {
    static var defaultSpring: Animation {
        .spring(response: 0.35, dampingFraction: 1)
    }
}
