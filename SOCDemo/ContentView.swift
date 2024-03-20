//
//  ContentView.swift
//  SOCDemo
//
//  Created by João Gabriel Pozzobon dos Santos on 16/03/24.
//

import SwiftUI
import SlideOverCard

struct ContentView: View {
    var body: some View {
        CardPreview()
    }
}

struct CardPreview: View {
    @State var isPesentingSheet = false
    
    var body: some View {
        TabView {
            CardPresenter()
                .tabItem {
                    Label("Main tab", systemImage: "circle")
                }
            
            Text("This is a mock tab.")
                .tabItem {
                    Label("Secondary tab", systemImage: "square")
                }
            
            Button("Present sheet") {
                isPesentingSheet = true
            }
                .sheet(isPresented: $isPesentingSheet) {
                    CardPresenter()
                }
                .tabItem {
                    Label("Tertiary tab", systemImage: "triangle")
                }
        }
    }
}

struct CardPresenter: View {
    @State var isPresented = false
    
    @State var disableDrag = false
    @State var disableDragToDismiss = false
    @State var hideExitButton = false
    
    var options: SOCOptions {
        SOCOptions.fromValues(disableDrag: disableDrag,
                              disableDragToDismiss: disableDragToDismiss,
                              hideDismissButton: hideExitButton)
    }
    
    var body: some View {
        VStack {
            Button("Present card") {
                isPresented = true
            }
            
            Toggle("Disable drag", isOn: $disableDrag)
            Toggle("Disable drag to dismiss", isOn: $disableDragToDismiss)
            Toggle("Hide exit button", isOn: $hideExitButton)
        }
        .slideOverCard(isPresented: $isPresented, options: options) {
            PlaceholderContent(isPresented: $isPresented)
        }
        .padding(32)
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

#Preview {
    ContentView()
}
