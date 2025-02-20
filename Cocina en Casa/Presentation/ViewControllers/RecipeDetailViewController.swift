//
//  RecipeDetailViewController.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 20/02/2025.
//

import Foundation
import UIKit

class RecipeDetailViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    
    
    
    private let viewModel: RecipeDetailViewModel
    
    init(
        viewModel:  RecipeDetailViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
