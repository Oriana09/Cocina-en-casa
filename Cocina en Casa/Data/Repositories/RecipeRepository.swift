//
//  RecipeRepository.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 20/01/2025.
//

import Foundation

final class RecipeRepository: RecipeRepositoryType {
    
    private let rometeDataSource: RecipeRemoteDataSourceType
    
    init(
        rometeDataSource: RecipeRemoteDataSourceType = RecipeRemoteDataSource()
    ) {
        self.rometeDataSource = rometeDataSource
    }
    
    func searchRecipes(query: String, offset: Int) async throws -> [Recipe] {
        return try await self.rometeDataSource.searchRecipes(
            query: query,
            offset: offset
        )
    }
}
