//
//  FetchRecipeDetailUseCase.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 18/02/2025.
//

import Foundation

protocol FetchRecipeDetailUseCasetype {
    func execute(id: Int, completion: @escaping (Result<RecipeDetail, Error>) -> Void )
}

final class FetchRecipeDetailUseCase: FetchRecipeDetailUseCasetype{
    private let  recipeRepository: RecipeDetailRepositoryType
    
    init(recipeRepository: RecipeDetailRepositoryType = RecipeDetailRepository()) {
        self.recipeRepository = recipeRepository
    }
    
    func execute(id: Int, completion: @escaping (Result<RecipeDetail, any Error>) -> Void) {
        self.recipeRepository.fetchRecipeDetail(by: id, completion: completion)
    }
}
