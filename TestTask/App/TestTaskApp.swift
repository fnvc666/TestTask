//
//  TestTaskApp.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

@main
struct TestTaskApp: App {
    @StateObject private var products = ProductsStore(repo: ProductRepositoryLocal())
    @StateObject private var favorites = FavoritesStore()
    @StateObject private var cart = CartStore()
    @StateObject private var theme = ThemeStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(products)
                .environmentObject(favorites)
                .environmentObject(cart)
                .environmentObject(theme)
                .preferredColorScheme(theme.theme.colorScheme)
        }
    }
}
