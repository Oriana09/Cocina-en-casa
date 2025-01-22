//
//  SearchRecipesUseCase.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 16/01/2025.
//

import Foundation

class SearchRecipesUseCase: SearchRecipesUseCaseType {
    private let recipeRepository: RecipeRepositoryType
    
    init(recipeRepository: RecipeRepositoryType) {
        self.recipeRepository = recipeRepository
    }
    
    func execute(query: String, offset: Int) async throws -> [Recipe] {
        return try await recipeRepository.searchRecipes(query: query, offset: offset)
    }
}
