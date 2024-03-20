//
//  SOCStyle.swift
//  
//
//  Created by João Gabriel Pozzobon dos Santos on 17/03/24.
//

import SwiftUI

/// A struct thtat defines the style of a `SlideOverCard`
public struct SOCStyle<S: ShapeStyle> {
    /// Initialize a style with a single value for corner radius
    public init(cornerRadius: CGFloat? = nil,
                continuous: Bool = true,
                innerPadding: CGFloat = 24.0,
                outerPadding: CGFloat = 6.0,
                dimmingOpacity: CGFloat = 0.3,
                style: S = Color(.systemGray6)) {
        let cornerRadius = cornerRadius ?? (UIScreen.main.displayCornerRadius ?? 41.5)-3.0
        
        self.init(cornerRadii: CGSize(width: cornerRadius, height: cornerRadius),
                  continuous: continuous,
                  innerPadding: innerPadding,
                  outerPadding: outerPadding,
                  dimmingOpacity: dimmingOpacity,
                  style: style)
    }
    
    /// Initialize a style with a custom size for corner radii
    public init(cornerRadii: CGSize,
                continuous: Bool = true,
                innerPadding: CGFloat = 20.0,
                outerPadding: CGFloat = 6.0,
                dimmingOpacity: CGFloat = 0.3,
                style: S = Color(.systemGray6)) {
        self.cornerRadii = cornerRadii
        self.continuous = continuous
        self.innerPadding = innerPadding
        self.outerPadding = outerPadding
        self.dimmingOpacity = dimmingOpacity
        self.style = style
    }
    
    let cornerRadii: CGSize
    let continuous: Bool
    
    let innerPadding: CGFloat
    let outerPadding: CGFloat
    
    let dimmingOpacity: CGFloat
    
    let style: S
}
