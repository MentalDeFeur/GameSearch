//
//  Game.swift
//  
//
//  Created by Joffrey TERRINE on 07/09/2025.
//

import Foundation

// Models.swift
struct Game: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let released: String?
    let rating: Double?
    let parent_platforms: [ParentPlatform]?
    let background_image: String?
}

struct ParentPlatform: Decodable, Hashable {
    let platform: Platform
}
struct Platform: Decodable, Hashable { let name: String }

struct Item: Identifiable {
    var id = UUID()
    var name: String
}

