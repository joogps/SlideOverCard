//
//  ColorScheme+UIKit.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 20/03/24.
//

import SwiftUI

extension ColorScheme {
    /// A property that binds a SwiftUI `ColorScheme` to a UIKit `UIUserInterfaceStyle`
    internal var uiKit: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        @unknown default:
            return .light
        }
    }
}
