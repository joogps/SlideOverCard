//
//  SlideOverCard.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 30/10/20.
//

import SwiftUI

struct SlideOverCardView<Content:View>: View {
    @Binding var isPresented: Bool
    
    var dragEnabled: Binding<Bool>?
    var dragToDismiss: Binding<Bool>?
    
    let content: () -> Content
    
    @State private var viewOffset: CGFloat = 0.0
    
    var body: some View {
        content()
            .padding(20)
            .background(RoundedRectangle(cornerRadius: 38.5, style: .continuous)
                            .fill(Color(.systemGray6)))
            .offset(x: 0, y: viewOffset/pow(2, abs(viewOffset)/500+1))
            .gesture(
                getBoolean(from: dragEnabled) ?
                DragGesture()
                    .onChanged { gesture in
                        viewOffset = gesture.translation.height
                    }
                    .onEnded() { _ in
                        isPresented = !(viewOffset > 175 && getBoolean(from: dragToDismiss))
                        viewOffset = .zero
                    } : nil
            )
    }
    
    func getBoolean(from binding: Binding<Bool>?, _ defaultValue: Bool = true) -> Bool {
        return (binding ?? .constant(defaultValue)).wrappedValue
    }
}

extension View {
    func slideOverCard<Content:View>(isPresented: Binding<Bool>, dragEnabled: Binding<Bool> = .constant(true), dragToDismiss: Binding<Bool> = .constant(true), @ViewBuilder content: @escaping () -> Content) -> some View {
        ZStack {
            self
            
            if isPresented.wrappedValue {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .zIndex(1)
                VStack {
                    Spacer()
                    
                    // If the device is an iPad, present centered and resized view
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        SlideOverCardView(isPresented: isPresented,
                                          dragEnabled: dragEnabled,
                                          dragToDismiss: dragToDismiss) {
                            content()
                        }.aspectRatio(1.0, contentMode: .fit)
                        Spacer()
                    } else {
                        SlideOverCardView(isPresented: isPresented,
                                          dragEnabled: dragEnabled,
                                          dragToDismiss: dragToDismiss) {
                            content()
                        }.padding(6)
                    }
                }.transition(.move(edge: .bottom))
                .animation(.spring(response: 0.35, dampingFraction: 1))
                .ignoresSafeArea(.container, edges: .bottom)
                .zIndex(2)
            }
        }
    }
}
    
struct SlideOverCard_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State var isPresented = true
        
        @State var canBeDragged = true
        @State var canBeDismissed = true
        
        var body: some View {
            VStack {
                Button("Show card", action: { isPresented = true })
                Toggle("Can be dragged", isOn: $canBeDragged)
                Toggle("Can be dismissed", isOn: $canBeDismissed)
            }.slideOverCard(isPresented: $isPresented, dragEnabled: $canBeDragged, dragToDismiss: $canBeDismissed, content: {
                PlaceholderContent()
            })

        }
    }
    
    struct PlaceholderContent: View {
        var body: some View {
            VStack(alignment: .center, spacing: 25) {
                HStack {
                    Spacer()
                    VStack {
                        Text("Large title").font(Font.largeTitle.weight(.bold))
                        Text("A nice and brief description")
                    }
                    Spacer()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous).fill(Color.gray)
                    Text("Content").foregroundColor(.white)
                }
            }.padding(14).frame(height: 420)
        }
    }
}
