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
    var onError: ((String, String) -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?
    var isLoading: ((Bool) -> Void)?
    
    init(
        recipeDetailUseCase: FetchRecipeDetailUseCasetype = FetchRecipeDetailUseCase()
    ) {
        self.RecipeDetailUseCase = recipeDetailUseCase
    }
    
    func loadRecipe(recipeId: Int) {
        self.isLoading?(true)
        
        RecipeDetailUseCase.execute(id: recipeId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipe):
                    self?.recipe = recipe
                    self?.isLoading?(false)
                    self?.onRecipeLoaded?()
                case .failure(let error):
                    if let  recipeError =  error as? RecipeError {
                        self?.handleError(recipeError)
                        self?.isLoading?(false)
                    } else {
                        self?.handleError(.unknown)
                    }
                }
            }
            
        }
    }
    
    func getSteps() -> [RecipeDetail.Instruction] {
        return self.recipe?.analyzedInstructions.first?.steps ?? []
    }
    
    func handleError(_ error: RecipeError) {
        let title: String
        let description: String
        
        switch error {
            
        case .invalidQuery:
            title = "Invalid query"
            description = "Please enter a valid search term."
        case .noResultsFound:
            title = "No results found."
            description = "No recipes were found for this query."
        case .networkError:
            title = "network Error"
            description = "There was a problem with the internet connection. Please try again."
        case .serverError:
            title = "server Error"
            description = "The server did not respond correctly. Please try again later."
        case .decodingError:
            title = "decoding Error"
            description = "An error occurred while processing the data. Please try again later."
        case .unknown:
            title = "Unknown error"
            description = "An unknown error occurred. Please try again later."
        }
        self.onError?(title, description)
    }
}

