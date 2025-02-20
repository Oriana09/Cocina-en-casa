//
//  RecipeDetailViewModel.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 20/02/2025.
//

import Foundation

class RecipeDetailViewModel {
    
    private let RecipeDetailUseCase: FetchRecipeDetailUseCasetype
    private(set) var recipe: RecipeDetail?
    
    var onRecipeLoaded: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(
        recipeDetailUseCase: FetchRecipeDetailUseCasetype = FetchRecipeDetailUseCase()
    ){
        self.RecipeDetailUseCase = recipeDetailUseCase
    }
    
    func loadRecipe(recipeId: Int) {
        RecipeDetailUseCase.execute(id: recipeId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipe):
                    self?.recipe = recipe
                 
                    self?.onRecipeLoaded?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func getSteps() -> [RecipeDetail.Instruction] {
        return self.recipe?.analyzedInstructions.first?.steps ?? []
    }
}
