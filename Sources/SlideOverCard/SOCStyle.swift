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
    public init(corners: CGFloat = (UIScreen.main.displayCornerRadius ?? 41.5)-3.0,
                continuous: Bool = true,
                innerPadding: CGFloat = 24.0,
                outerPadding: CGFloat = 6.0,
                dimmingOpacity: CGFloat = 0.3,
                style: S = Color(.systemGray6)) {
        self.init(corners: CGSize(width: corners, height: corners),
                  continuous: continuous,
                  innerPadding: innerPadding,
                  outerPadding: outerPadding,
                  dimmingOpacity: dimmingOpacity,
                  style: style)
    }
    
    /// Initialize a style with a custom corner size
    public init(corners: CGSize,
                continuous: Bool = true,
                innerPadding: CGFloat = 20.0,
                outerPadding: CGFloat = 6.0,
                dimmingOpacity: CGFloat = 0.3,
                style: S = Color(.systemGray6)) {
        self.cornerSize = corners
        self.continuous = continuous
        self.innerPadding = innerPadding
        self.outerPadding = outerPadding
        self.dimmingOpacity = dimmingOpacity
        self.style = style
    }
    
    let cornerSize: CGSize
    let continuous: Bool
    
    let innerPadding: CGFloat
    let outerPadding: CGFloat
    
    let dimmingOpacity: CGFloat
    
    let style: S
}
