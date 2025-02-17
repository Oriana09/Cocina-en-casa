//
//  RecipeSearchViewModel.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 03/12/2024.
//

import Foundation
import UIKit

@MainActor
class RecipeSearchViewModel {
    
    private let searchUseCase: SearchRecipesUseCaseType
    
    private(set) var recipes: [Recipe] = []
    
    var onDataUpdated: (() -> Void)?
    var onError: ((String, String) -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?
    
    private var isLoading = false {
        didSet {
            onLoadingStateChanged?(isLoading)
        }
    }
    
    private var offset = 0
    private var query: String?
    
    init(
        searchUseCase: SearchRecipesUseCaseType = SearchRecipesUseCase()
    ) {
        self.searchUseCase = searchUseCase
    }
    
    func searchRecipes(query: String) {
        guard !query.isEmpty else { return }
        self.query = query
        self.offset = 0
        self.recipes = []
        self.fetchRecipes()
    }
    
    func loadMoreData() {
        guard let query = self.query, !query.isEmpty, !isLoading else { return }
        self.offset += 10
        self.fetchRecipes()
    }
    
    private func fetchRecipes() {
        guard let query = self.query else { return }
        
        isLoading = true
        
        Task(priority: .userInitiated) {
            do {
                let newRecipes = try await self.searchUseCase.execute(
                    query: query,
                    offset: offset
                )
                self.recipes.append(contentsOf: newRecipes)
                self.isLoading = false
                DispatchQueue.main.async {
                    self.onDataUpdated?()
                    
                }
            } catch let error as RecipeError {
                self.isLoading = false
                DispatchQueue.main.async {
                    self.handleError(error)
                }
            }
        }
    }
    
    private func handleError(_ error: RecipeError) {
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
