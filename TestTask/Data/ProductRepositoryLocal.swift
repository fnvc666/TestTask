//
//  ProductRepositoryLocal.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import Foundation

final class ProductRepositoryLocal {
    public init() {}
    
    public func fetch() async throws -> [Product] {
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
            throw NSError(domain: "product", code: 1, userInfo: [NSLocalizedDescriptionKey: "products.json not found"])
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        return try decoder.decode([Product].self, from: data)
    }
}
