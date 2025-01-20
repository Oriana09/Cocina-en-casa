//
//  RecipeRepository.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 16/01/2025.
//

import Foundation

protocol RecipeRepositoryType {
    func searchRecipes(query: String, offset: Int) async throws -> [Recipe]
}
