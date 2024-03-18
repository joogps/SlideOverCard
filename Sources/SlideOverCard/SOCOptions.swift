//
//  SOCOptions.swift
//  
//
//  Created by João Gabriel Pozzobon dos Santos on 17/03/24.
//

import Foundation

/// A structure that defines interaction options of a `SlideOverCard`
public struct SOCOptions: OptionSet {
    public let rawValue: Int8
    
    public init(rawValue: Int8) {
        self.rawValue = rawValue
    }
    
    /// Disable dragging of the card completely, keeping it static
    public static let disableDrag = SOCOptions(rawValue: 1)
    /// Disable the ability of dismissing the card by dragging it down
    public static let disableDragToDismiss = SOCOptions(rawValue: 1 << 1)
    /// Hide the default dismiss button
    public static let hideDismissButton = SOCOptions(rawValue: 1 << 2)
    
    /// Create a `SOCOptions` from a set of values
    public static func fromValues(disableDrag: Bool = false,
                                    disableDragToDismiss: Bool = false,
                                    hideDismissButton: Bool = false) -> SOCOptions {
        var options = SOCOptions()
        if disableDrag { options.insert(.disableDrag) }
        if disableDragToDismiss { options.insert(.disableDragToDismiss) }
        if hideDismissButton { options.insert(.hideDismissButton) }
        return options
    }
}
