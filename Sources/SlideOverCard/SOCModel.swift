//
//  SOCModel.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 19/03/24.
//

import SwiftUI

/// A data model shared  between `SOCModifier`, `SOCManager` and `SlideOverCard`, containing the state of the card
internal class SOCModel: ObservableObject {
    @Published var showCard: Bool = false
}
