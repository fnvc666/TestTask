//
//  ProductDetailsViewModel.swift
//  TestTask
//
//  Created by Pavel Pavel on 05/10/2025.
//

import Foundation

final class ProductDetailsViewModel: ObservableObject {
    let product: Product
    private let favorites: FavoritesStore
    private let cart: CartStore

    init(product: Product, favorites: FavoritesStore, cart: CartStore) {
        self.product = product
        self.favorites = favorites
        self.cart = cart
    }

    var isFavorite: Bool { favorites.contains(product.id) }
    func toggleFavorite() { favorites.toggle(product.id) }
    func addToCart() { cart.add(product.id) }
}
