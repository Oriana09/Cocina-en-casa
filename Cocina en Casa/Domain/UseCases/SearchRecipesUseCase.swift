//
//  SearchRecipesUseCase.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 16/01/2025.
//

import Foundation

protocol SearchRecipesUseCaseType {
    func execute(query: String, offset: Int) async throws -> [Recipe]
}

class SearchRecipesUseCase: SearchRecipesUseCaseType {
    private let recipeRepository: RecipeRepositoryType
    
    init(
        recipeRepository: RecipeRepositoryType = RecipeRepository()
    ) {
        self.recipeRepository = recipeRepository
    }
    
    func execute(query: String, offset: Int) async throws -> [Recipe] {
        return try await recipeRepository.searchRecipes(
            query: query,
            offset: offset
        )
    }
}
