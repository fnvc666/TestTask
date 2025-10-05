//
//  ProductsStore.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import Foundation

@MainActor
final class ProductsStore: ObservableObject {
    @Published private(set) var products: [Product] = []
    
    private let repo: ProductRepositoryLocal
    
    init(repo: ProductRepositoryLocal) {
        self.repo = repo
    }
    
    func loadIfNeeded() async {
        guard products.isEmpty else { return }
        do {
            products = try await repo.fetch()
        } catch {
            print("products load error: \(error)")
        }
    }
    
    func product(by id: UUID) -> Product? {
        products.first { $0.id == id }
    }
}
