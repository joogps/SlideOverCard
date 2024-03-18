//
//  Accessories.swift
//  
//
//  Created by João Gabriel Pozzobon dos Santos on 24/04/21.
//

import SwiftUI

/// A button style that represents a main action in a `SlideOverCard`
public struct SOCActionButton: ButtonStyle {
    let textColor: Color
    public init(textColor: Color = .white) {
        self.textColor = textColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
                .font(Font.body.weight(.medium))
                .padding(.vertical, 20)
                .foregroundColor(textColor)
            Spacer()
        }
        .background(Color.accentColor)
        .overlay(configuration.isPressed ? Color.black.opacity(0.2) : nil)
        .cornerRadius(12)
    }
}

/// A button style that represents an alternative action in a `SlideOverCard`
public struct SOCAlternativeButton: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        SOCActionButton(textColor: .primary).makeBody(configuration: configuration).accentColor(Color(.systemGray5))
    }
}

/// A button style with no background and tinted text in a `SlideOverCard`
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

/// A round button that triggers the dismissal of a `SlideOverCard`
public struct SOCDismissButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    public var body: some View {
        ZStack {
            Circle()
                .fill(Color(white: colorScheme == .dark ? 0.19 : 0.89))
            Image(systemName: "xmark")
                .font(.system(size: 13.0, weight: .bold))
                .foregroundColor(Color(white: colorScheme == .dark ? 0.62 : 0.51))
        }
    }
}

struct Acessories_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Button("Action") {
                
            }
            .buttonStyle(SOCActionButton())
            
            Button("Alternative") {
                
            }
            .buttonStyle(SOCAlternativeButton())
            
            Button("Empty") {
                
            }
            .buttonStyle(SOCEmptyButton())
            
            SOCDismissButton()
        }.previewLayout(.sizeThatFits)
    }
}
