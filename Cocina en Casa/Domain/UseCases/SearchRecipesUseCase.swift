//
//  SearchRecipesUseCase.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 16/01/2025.
//

import Foundation

class SearchRecipesUseCase: SearchRecipesUseCaseType {
    private let recipeRepository: RecipeRepository
    
    init(recipeRepository: RecipeRepository) {
        self.recipeRepository = recipeRepository
    }
    func execute(query: String) async throws -> [Recipe] {
        return try await recipeRepository.searchRecipes(query: query)
    }
}
