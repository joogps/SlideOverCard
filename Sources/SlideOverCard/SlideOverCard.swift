//
//  SlideOverCard.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 30/10/20.
//

import SwiftUI

public struct SlideOverCardView<Content:View>: View {
    var isPresented: Binding<Bool>
    
    let onDismiss: (() -> Void)?
    
    var dragEnabled: Binding<Bool> = .constant(true)
    var dragToDismiss: Binding<Bool> = .constant(true)
    var displayExitButton: Binding<Bool> = .constant(true)
    
    let content: Content
    
    init(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, dragEnabled: Binding<Bool> = .constant(true), dragToDismiss: Binding<Bool> = .constant(true), displayExitButton: Binding<Bool> = .constant(true), content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.onDismiss = onDismiss
        self.dragEnabled = dragEnabled
        self.dragToDismiss = dragToDismiss
        self.displayExitButton = displayExitButton
        self.content = content()
    }
    
    @State private var viewOffset: CGFloat = 0.0
    
    public var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            if displayExitButton.wrappedValue {
                Button(action: {
                    withAnimation { isPresented.wrappedValue = false }
                    if (onDismiss != nil) { onDismiss!() }
                }) {
                    SOCExitButton()
                }.frame(width: 24, height: 24)
            }
            content
                .padding([.horizontal, displayExitButton.wrappedValue ? .bottom : .vertical], 14)
        }.padding(20)
        .background(RoundedRectangle(cornerRadius: 38.5, style: .continuous)
                        .fill(Color(.systemGray6)))
        .offset(x: 0, y: viewOffset/pow(2, abs(viewOffset)/500+1))
        .gesture(
            dragEnabled.wrappedValue ?
                DragGesture()
                .onChanged { gesture in
                    viewOffset = gesture.translation.height
                }
                .onEnded() { _ in
                    withAnimation {
                        if viewOffset > 175 && dragToDismiss.wrappedValue {
                            isPresented.wrappedValue = false
                            if (onDismiss != nil) { onDismiss!() }
                        }
                        viewOffset = .zero
                    }
                } : nil
        )
    }
}

protocol SOCButton: ButtonStyle {
    var foregroundColor: Color { get }
    var backgroundColor: Color { get }
}

extension SOCButton {
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
                .font(Font.body.weight(.medium))
                .padding(.vertical, 20)
                .foregroundColor(foregroundColor)
            Spacer()
        }.background(backgroundColor).cornerRadius(12).overlay(configuration.isPressed ? Color.black.opacity(0.2) : nil)
    }
}

public struct SOCActionButton: SOCButton {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .accentColor
    
    public init() {}
}

public struct SOCAlternativeButton: SOCButton {
    var foregroundColor: Color = .primary
    var backgroundColor: Color = Color(.systemGray5)
    
    public init() {}
}

public struct SOCEmptyButton: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.body.weight(.bold))
            .padding(.top, 18)
            .foregroundColor(.accentColor)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

public struct SOCExitButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    public var body: some View {
        ZStack {
            Circle()
                .fill(Color(white: colorScheme == .dark ? 0.19 : 0.93))
            Image(systemName: "xmark")
                .resizable()
                .scaledToFit()
                .font(Font.body.weight(.bold))
                .scaleEffect(0.416)
                .foregroundColor(Color(white: colorScheme == .dark ? 0.62 : 0.51))
        }
    }
}

extension View {
    public func slideOverCard<Content:View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, dragEnabled: Binding<Bool> = .constant(true), dragToDismiss: Binding<Bool> = .constant(true), displayExitButton: Binding<Bool> = .constant(true), content: @escaping () -> Content) -> some View {
        ZStack {
            self
            
            if isPresented.wrappedValue {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .zIndex(1)
                VStack {
                    Spacer()
                    
                    // If the device is an iPad, present centered and resized view
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        SlideOverCardView(isPresented: isPresented,
                                          onDismiss: onDismiss,
                                          dragEnabled: dragEnabled,
                                          dragToDismiss: dragToDismiss,
                                          displayExitButton: displayExitButton) {
                            content()
                        }.aspectRatio(1.0, contentMode: .fit)
                        Spacer()
                    } else {
                        SlideOverCardView(isPresented: isPresented,
                                          onDismiss: onDismiss,
                                          dragEnabled: dragEnabled,
                                          dragToDismiss: dragToDismiss,
                                          displayExitButton: displayExitButton) {
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
    
    public func slideOverCard<Item:Identifiable, Content:View>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, dragEnabled: Binding<Bool> = .constant(true), dragToDismiss: Binding<Bool> = .constant(true), displayExitButton: Binding<Bool> = .constant(true), content: @escaping (Item) -> Content) -> some View {
        return Group {
            if item.wrappedValue != nil {
                let binding = Binding(get: { item.wrappedValue != nil }, set: { if !$0 { item.wrappedValue = nil } })
                self.slideOverCard(isPresented: binding, onDismiss: onDismiss, dragEnabled: dragEnabled, dragToDismiss: dragToDismiss, displayExitButton: displayExitButton, content: { content(item.wrappedValue!) } )
            } else { self }
        }
    }
}

struct SlideOverCard_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
        PreviewWrapper().environment(\.colorScheme, .dark)
    }
    
    struct PreviewWrapper: View {
        @State var isPresented = true
        
        @State var canBeDragged = true
        @State var canBeDismissed = true
        @State var showingExitButton = true
        
        var body: some View {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                VStack {
                    Button("Show card", action: { withAnimation { isPresented = true } })
                    Toggle("Can be dragged", isOn: $canBeDragged)
                    Toggle("Can be dismissed", isOn: $canBeDismissed)
                    Toggle("Showing exit button", isOn: $showingExitButton)
                }
            }.slideOverCard(isPresented: $isPresented, dragEnabled: $canBeDragged, dragToDismiss: $canBeDismissed, displayExitButton: $showingExitButton, content: {
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
                        Text("Large title").font(.system(size: 28, weight: .bold))
                        Text("A nice and brief description").font(.system(size: 13))
                    }
                    Spacer()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous).fill(Color.gray)
                    Text("Content").foregroundColor(.white)
                }
                
                VStack(spacing: 0) {
                    Button("Do something", action: {
                    }).buttonStyle(SOCActionButton())
                    Button("Just skip it", action: {
                    }).buttonStyle(SOCEmptyButton())
                }
            }.frame(height: 480)
        }
    }
}
