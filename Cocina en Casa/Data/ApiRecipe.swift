//
//  File.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 17/01/2025.
//

import Foundation
 

struct ApiRecipe: Codable{
    let results: [Item]
}

// MARK: - Item
struct  Item: Codable {
    let id: Int
    let title: String
    let image: String
}
