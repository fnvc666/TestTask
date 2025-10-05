//
//  CartViewModel.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

@MainActor
final class CartViewModel: ObservableObject {
    struct Entry: Identifiable, Hashable {
        let product: Product
        var amount: Int
        var id: UUID { product.id }
        var subtotal: Double { Double(amount) * product.price }
    }
    
    @Published private(set) var entries: [Entry] = []
    @Published private(set) var total: Double = 0
    
    let products: ProductsStore
    let cart: CartStore
    
    init(products: ProductsStore, cart: CartStore) {
        self.products = products
        self.cart = cart
        rebuild()
    }
    
    func rebuild() {
        entries = cart.items.compactMap { (id, amount) -> Entry? in
            guard let product = products.product(by: id) else { return nil }
            return Entry(product: product, amount: amount)
        }
        
        total = entries.reduce(0, { $0 + $1.subtotal })
    }
    
    func increase(_ id: UUID) { cart.add(id); rebuild() }
    func decrease(_ id: UUID) { cart.dec(id); rebuild() }
    func clear() { cart.clear(); rebuild() }
}
