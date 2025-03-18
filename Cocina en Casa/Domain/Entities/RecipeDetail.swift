//
//  RecipeDetail.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 17/02/2025.
//

import Foundation

struct RecipeDetail: Codable {
    let id: Int
    let title: String
    let image: String
    let readyInMinutes: Int
    let servings: Int
    let analyzedInstructions: [Instructions]
    
    // MARK: - AnalyzedInstruction
    struct Instructions: Codable {
        let steps: [Instruction]
    }
    
    
    // MARK: - Instruction
    struct Instruction: Codable {
        let number: Int
        let step: String
    }
}
