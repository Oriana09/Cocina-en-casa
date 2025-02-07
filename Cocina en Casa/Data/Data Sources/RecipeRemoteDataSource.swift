//
//  ConfigDataSource.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 05/02/2025.
//

import Foundation

protocol RecipeRemoteDataSourceType {
    func searchRecipes(query: String, offset: Int) async throws -> [Recipe]
}

final class RecipeRemoteDataSource: RecipeRemoteDataSourceType {
    
    private let networkClient: NetworkClientType
    private let baseURL =  "https://api.spoonacular.com/"
    private let apiKey = "9a13bace7b934b8baaf9698a7a8baaea"
    
    init(
        networkClient: NetworkClientType = NetworkClient()
    ) {
        self.networkClient = networkClient
    }
    
    func searchRecipes(query: String, offset: Int) async throws -> [Recipe] {
        let parameters = [
            "apiKey": apiKey,
            "query": query,
            "offset": String(offset),
            "number": "10"
        ]
        do {
            let response: RecipeResponse = try await networkClient.performRequest(
                endpoint: baseURL + "recipes/complexSearch",
                parameters: parameters
            )
            return response.results
        } catch {
            throw mapNetworkErrorToDomainError(error)
        }
    }
}

private func mapNetworkErrorToDomainError(_ error: Error) -> RecipeError {
    if let networkError = error as? NetworkError {
        switch networkError {
        case .invalidURL:
            return .invalidQuery
        case .unexpectedStatusCode:
            return .serverError
        case .decodingFailed:
            return .decodingError
        default:
            return .unknown
        }
    }
    return .unknown
}

