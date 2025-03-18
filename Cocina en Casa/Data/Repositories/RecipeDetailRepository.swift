//
//  RecipeDetailRepository.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 18/02/2025.
//

import Foundation

final class RecipeDetailRepository: RecipeDetailRepositoryType {
    
    private let remoteDataSource: RecipeDetailRemoteDataSourceType
    
    init(
        remoteDataSource: RecipeDetailRemoteDataSourceType = RecipeDetailRemoteDataSource()
    ) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchRecipeDetail(by id: Int, completion: @escaping (Result<RecipeDetail, any Error>) -> Void) {
        self.remoteDataSource.fetchRecipeDetail(by: id, completion: completion)
    }
}
