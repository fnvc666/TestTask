//
//  CatalogViewModel.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

final class CatalogViewModel: ObservableObject {
    @Published var query: String = ""
    @Published private(set) var items: [Product] = []
    @Published private(set) var isLoading = false
    
    private let products: ProductsStore
    private let favorites: FavoritesStore
    
    init(products: ProductsStore, favorites: FavoritesStore, cart: CartStore) {
        self.products = products
        self.favorites = favorites
    }
    
    func load() async {
        guard items.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }
        
        await products.loadIfNeeded()
        items = await products.products
    }
    
    var filtered: [Product] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return items }
        return items.filter {
            $0.title.lowercased().contains(q) || $0.description.lowercased().contains(q)
        }
    }
    
    func isFavorite(_ id: UUID) -> Bool { favorites.contains(id) }
}
