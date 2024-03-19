//
//  UIScreen+CornerRadius.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 19/03/24.
//

import SwiftUI

/// Provide access to the corner radius of the display
/// From https://github.com/kylebshr/ScreenCorners
internal extension UIScreen {
    private static let cornerRadiusKey: String = {
        let components = ["Radius", "Corner", "display", "_"]
        return components.reversed().joined()
    }()
    
    /// The corner radius of the display. Uses a private property of `UIScreen`,
    /// and may report 0 if the API changes.
    internal var displayCornerRadius: CGFloat? {
        guard let cornerRadius = self.value(forKey: Self.cornerRadiusKey) as? CGFloat else {
            assertionFailure("Failed to detect screen corner radius")
            return nil
        }
        
        return cornerRadius
    }
}
