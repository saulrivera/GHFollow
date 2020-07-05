//
//  PersistanceManager.swift
//  GHFollow
//
//  Created by Saul Rivera on 01/07/20.
//  Copyright © 2020 Saul Rivera. All rights reserved.
//

import Foundation

enum PersitanceActionType {
    case add, remove
}

enum PersistanceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys { static let favorites = "favorites" }
    
    static func updateWith(favorite: Follower, actionType: PersitanceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { (result) in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                completed(save(favorites: favorites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let followers = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(followers))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
        } catch {
            return .unableToFavorite
        }
        
        return nil
    }
}
