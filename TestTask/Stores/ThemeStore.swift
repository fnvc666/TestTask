//
//  ThemeStore.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

final class ThemeStore: ObservableObject {
    @Published var theme: AppTheme {
        didSet { save() }
    }
    
    private let key = "theme"
    
    init() {
        if let raw = UserDefaults.standard.string(forKey: key),
           let temp = AppTheme(rawValue: raw) {
            theme = temp
        } else {
            theme = .system
        }
    }
    
    // MARK: - UserDefaults
    
    private func save() {
        UserDefaults.standard.set(theme.rawValue, forKey: key)
    }
}
