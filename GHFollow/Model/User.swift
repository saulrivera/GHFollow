//
//  User.swift
//  GHFollow
//
//  Created by Saul Rivera on 27/06/20.
//  Copyright © 2020 Saul Rivera. All rights reserved.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
