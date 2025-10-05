//
//  AppTheme.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

enum AppTheme: String, Codable, Identifiable, CaseIterable {
    case system, light, dark
    var id: String { rawValue }
    
    var title: String {
        switch self {
            case .system: return "Системная"
            case .light: return "Светлая"
            case .dark: return "Тёмная"
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
            case .system: nil
            case .light:  .light
            case .dark:   .dark
        }
    }
}
