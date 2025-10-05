//
//  Product.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import Foundation

struct Product: Identifiable, Decodable, Hashable {
    let id: UUID
    let title: String
    let description: String
    let price: Double
}
