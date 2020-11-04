//
//  SlideOverCard.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 30/10/20.
//

import SwiftUI

struct SlideOverCard<Content:View>: View {
    @Binding var isPresented: Bool
    
    let content: () -> Content
    
    @State private var viewOffset: CGFloat = 0.0
    
    var body: some View {
        content()
            .padding(20)
            .background(RoundedRectangle(cornerRadius: 38.5, style: .continuous)
                            .fill(Color(.systemGray6)))
            .offset(x: 0, y: viewOffset/pow(2, (abs(viewOffset)/500+1)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        viewOffset = gesture.translation.height
                    }
                    .onEnded() { _ in
                        isPresented = !(viewOffset > 175)
                        viewOffset = .zero
                    }
            )
    }
}

extension View {
    func slideOverCard<Content:View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        ZStack {
            self.zIndex(1)
            
            if isPresented.wrappedValue {
                let isiPad = UIDevice.current.userInterfaceIdiom == .pad
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(2)
                VStack {
                    Spacer()
                    SlideOverCard(isPresented: isPresented) {
                        content()
                    }.padding(isiPad ? 0 : 6)
                    if isiPad { Spacer() }
                }.transition(isiPad ?  AnyTransition.offset(y: 48).combined(with: .opacity) : .move(edge: .bottom))
                .animation(.spring(response: 0.35, dampingFraction: 1))
                .ignoresSafeArea(.container, edges: .bottom)
                .zIndex(3)
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
        
        var body: some View {
            Button("Show card", action: {
                    withAnimation { isPresented = true } }).slideOverCard(isPresented: $isPresented, content: {
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
