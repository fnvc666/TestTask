//
//  CartViewModel.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

@MainActor
final class CartViewModel: ObservableObject {
    typealias Entry = (product: Product, amount: Int)
    
    @Published private(set) var entries: [Entry] = []
    @Published private(set) var total: Double = 0
    
    private let products: ProductsStore
    private let cart: CartStore
    
    init(products: ProductsStore, cart: CartStore) {
        self.products = products
        self.cart = cart
        rebuild()
    }
    
    func rebuild() {
        entries = cart.items.compactMap { (id, amount) in
            guard let product = products.product(by: id) else { return nil }
            return (product, amount)
        }
    }
    
    func increase(_ id: UUID) { cart.add(id); rebuild() }
    func decrease(_ id: UUID) { cart.dec(id); rebuild() }
    func clear() { cart.clear(); rebuild() }
}
