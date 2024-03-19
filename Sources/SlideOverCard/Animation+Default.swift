//
//  File.swift
//  
//
//  Created by João Gabriel Pozzobon dos Santos on 19/03/24.
//

import SwiftUI

extension Animation {
    internal static var defaultSpring: Animation {
        .spring(response: 0.35, dampingFraction: 1)
    }
}
