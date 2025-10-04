//
//  CartStore.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

final class CartStore: ObservableObject {
    @Published private(set) var items: [UUID: Int] = [:] {
        didSet { save() }
    }
    
    private let key = "cart.items"
    
    init() {
        load()
    }
    
    func add(_ id: UUID) {
        items[id, default: 0] += 1
    }
    
    func clear() {
        items.removeAll()
    }
    
    // MARK: - UserDefaults

    private func save() {
        let dict = items.reduce(into: [String: Int]()) { result, pair in
            result[pair.key.uuidString] = pair.value
        }
        UserDefaults.standard.set(dict, forKey: key)
    }

    private func load() {
        guard let dict = UserDefaults.standard.dictionary(forKey: key) as? [String: Int] else { return }
        items = dict.reduce(into: [UUID: Int]()) { result, pair in
            if let id = UUID(uuidString: pair.key) {
                result[id] = pair.value
            }
        }
    }
}
