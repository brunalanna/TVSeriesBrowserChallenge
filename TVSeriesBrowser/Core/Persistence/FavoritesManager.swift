//
//  FavoritesManager.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//


import Foundation

final class FavoritesManager: ObservableObject {
    
    @Published private(set) var favoriteShowIDs: Set<Int> = []
    
    static let shared = FavoritesManager()
    
    private let storageKey = "favorite_show_ids"
    
    private init() {
        load()
    }
    
    // MARK: - Public Methods
    
    func isFavorite(showID: Int) -> Bool {
        favoriteShowIDs.contains(showID)
    }
    
    func toggleFavorite(showID: Int) {
        if favoriteShowIDs.contains(showID) {
            favoriteShowIDs.remove(showID)
        } else {
            favoriteShowIDs.insert(showID)
        }
        save()
    }
    
    // MARK: - Persistence
    
    private func load() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode(Set<Int>.self, from: data) {
            favoriteShowIDs = decoded
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(favoriteShowIDs) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
}
