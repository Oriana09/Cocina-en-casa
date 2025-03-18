//
//  RecipeDetailRemoteDataSource.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 18/02/2025.
//

import Foundation

protocol RecipeDetailRemoteDataSourceType{
    func fetchRecipeDetail(by id: Int, completion: @escaping (Result<RecipeDetail, Error>) -> Void)
}

final class RecipeDetailRemoteDataSource: RecipeDetailRemoteDataSourceType {
    
    private let networkClient: NetworkClientType
    
    init(
        networkClient: NetworkClientType = NetworkClient()
    ) {
        self.networkClient = networkClient
    }
    
    func fetchRecipeDetail(by id: Int, completion: @escaping (Result<RecipeDetail, any Error>) -> Void) {
        
        let endpoint = "https://api.spoonacular.com/recipes/\(id)/information"
        let parameters = ["apiKey": "9a13bace7b934b8baaf9698a7a8baaea"]
        
        Task {
            do {
                let recipeDetail: RecipeDetail = try await networkClient.performRequest(
                    endpoint: endpoint,
                    parameters: parameters
                )
                DispatchQueue.main.async {
                    completion(.success(recipeDetail))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
