//
//  RecipeRepository.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 20/01/2025.
//

import Foundation

final class ConfigRepository: RecipeRepository {
    
    private let rometeDataSource: RemoteDataSource
    
    init(rometeDataSource: RemoteDataSource = configRemoteDataSource()) {
        self.rometeDataSource = rometeDataSource
    }
    
    func searchRecipes(query: String, offset: Int) async throws -> [Recipe] {
        
        return try await rometeDataSource.searchRecipes(query: query, offset: offset)
    }
}
