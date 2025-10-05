//
//  ContentView.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

enum AppTab: Hashable { case catalog, browser, settings }

struct ContentView: View {
    @EnvironmentObject var products: ProductsStore
    @EnvironmentObject var favorites: FavoritesStore
    @EnvironmentObject var cart: CartStore
    @EnvironmentObject var theme: ThemeStore
    
    @State private var tab: AppTab = .catalog
    
    var body: some View {
        TabView(selection: $tab) {
            Tab("Catalog", systemImage: "bag", value: AppTab.catalog) {
                CatalogView(vm: .init(products: products, favorites: favorites, cart: cart))
            }
            Tab("Browser", systemImage: "network", value: AppTab.browser) {
                BrowserView()
            }
            Tab("Settings", systemImage: "gear", value: AppTab.settings) {
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
