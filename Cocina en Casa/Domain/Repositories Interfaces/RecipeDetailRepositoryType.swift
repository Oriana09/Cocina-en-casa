//
//  RecipeDetailRepositoryType.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 17/02/2025.
//

import Foundation

protocol RecipeDetailRepositoryType {
    func fetchRecipeDetail(
        by id: Int,
        completion: @escaping (
            Result<RecipeDetail, Error>
        ) -> Void
    )
}
