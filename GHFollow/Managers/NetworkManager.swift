//
//  NetworkManager.swift
//  GHFollow
//
//  Created by Saul Rivera on 27/06/20.
//  Copyright © 2020 Saul Rivera. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    private init() { }
    
    private let baseURL = "https://api.github.com/users"
    
    func getFollowers(for useraname: String, in page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = "\(baseURL)/\(useraname)/followers?per_page=99&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
                
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
