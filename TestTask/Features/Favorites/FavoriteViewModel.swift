//
//  FavoriteViewModel.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

@MainActor
final class FavoriteViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var items: [Product] = []
    
    private let products: ProductsStore
    private let favorites: FavoritesStore
    
    init(products: ProductsStore, favorites: FavoritesStore) {
        self.products = products
        self.favorites = favorites
        
        refresh()
    }
    
    func refresh() {
        items = products.products.filter { favorites.ids.contains($0.id) }
    }
    
    var filtered: [Product] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return items}
        
        return items.filter {
            $0.title.lowercased().contains(q)
        }
    }
    
    func remove(_ id: UUID) {
        favorites.toggle(id)
        refresh()
    }
}
