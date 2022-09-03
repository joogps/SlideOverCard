//
//  Previews.swift
//  
//
//  Created by João Gabriel Pozzobon dos Santos on 02/09/22.
//

import SwiftUI

/// `SlideOverCard` previews
struct SlideOverCard_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
        PreviewWrapper().environment(\.colorScheme, .dark)
    }
    
    struct PreviewWrapper: View {
        @State var isPresented = true
        
        @State var disableDrag = false
        @State var disableDragToDismiss = false
        @State var hideExitButton = false
        
        var options: SOCOptions {
            var options = SOCOptions()
            if disableDrag { options.insert(.disableDrag) }
            if disableDragToDismiss { options.insert(.disableDragToDismiss) }
            if hideExitButton { options.insert(.hideDismissButton) }
            return options
        }
        
        var body: some View {
            ZStack {
                Color(.systemBackground).edgesIgnoringSafeArea(.all)
                VStack {
                    Button("Show card", action: {
                        isPresented = true
                    })
                    
                    Toggle("Disable drag", isOn: $disableDrag)
                    Toggle("Disable drag to dismiss", isOn: $disableDragToDismiss)
                    Toggle("Hide exit button", isOn: $hideExitButton)
                }.padding()
            }.slideOverCard(isPresented: $isPresented, options: options) {
                PlaceholderContent(isPresented: $isPresented)
            }
        }
    }
    
    struct PlaceholderContent: View {
        @Binding var isPresented: Bool
        
        var body: some View {
            VStack(alignment: .center, spacing: 25) {
                VStack {
                    Text("Large title").font(.system(size: 28, weight: .bold))
                    Text("A nice and brief description")
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous).fill(Color.gray)
                    Text("Content").foregroundColor(.white)
                }
                
                VStack(spacing: 0) {
                    Button("Do something", action: {
                        isPresented = false
                    }).buttonStyle(SOCActionButton())
                    Button("Just skip it", action: {
                        isPresented = false
                    }).buttonStyle(SOCEmptyButton())
                }
            }.frame(height: 480)
        }
    }
}
