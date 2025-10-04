//
//  AppTheme.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import Foundation

enum AppTheme: String, Codable, Identifiable {
    case system, light, dark
    var id: String { rawValue }
}
