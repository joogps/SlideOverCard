//
//  Accessories.swift
//  
//
//  Created by João Gabriel Pozzobon dos Santos on 24/04/21.
//

import SwiftUI

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
        }.background(Color.accentColor).overlay(configuration.isPressed ? Color.black.opacity(0.2) : nil).cornerRadius(12)
    }
}

public struct SOCAlternativeButton: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        SOCActionButton(textColor: .primary).makeBody(configuration: configuration).accentColor(Color(.systemGray5))
    }
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

struct Acessories_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Button("Action") {}.buttonStyle(SOCActionButton())
            Button("Alternative") {}.buttonStyle(SOCAlternativeButton())
            Button("Empty") {}.buttonStyle(SOCEmptyButton())
            SOCExitButton()
        }.previewLayout(.sizeThatFits)
    }
}
