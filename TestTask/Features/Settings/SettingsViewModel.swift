//
//  SettingsViewModel.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    @Published var selected: AppTheme
    private let store: ThemeStore
    
    init(theme store: ThemeStore) {
        self.store = store
        self.selected = store.theme
    }
    
    func set(_ theme: AppTheme) {
        store.theme = theme
        selected = theme
    }
}
