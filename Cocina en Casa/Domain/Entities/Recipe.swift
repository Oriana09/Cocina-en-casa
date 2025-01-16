//
//  Recipe.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 10/01/2025.
//

import Foundation

struct RecipeResponse: Codable {
    let results: [Recipe]
}

// MARK: - Item
struct  Recipe: Codable {
    let id: Int
    let title: String
    let image: String
}
