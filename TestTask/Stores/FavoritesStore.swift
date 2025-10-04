//
//  FavoritesStore.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import Foundation

final class FavoritesStore: ObservableObject {
    @Published private(set) var ids: Set<UUID> = [] {
        didSet { save() }
    }
    
    private let key = "favorites.ids"
    
    init() {
        load()
    }
    
    func toggle(_ id: UUID) {
        if ids.contains(id) {
            ids.remove(id)
        } else {
            ids.insert(id)
        }
    }
    
    func contains(_ id: UUID) -> Bool {
        ids.contains(id)
    }
    
    // MARK: - UserDefaults
    
    private func save() {
        let raws = ids.map(\.uuidString)
        UserDefaults.standard.set(raws, forKey: key)
    }
    
    private func load() {
        let raws = (UserDefaults.standard.array(forKey: key) as? [String]) ?? []
        ids = Set(raws.compactMap(UUID.init))
    }
}
