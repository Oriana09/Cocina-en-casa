//
//  RecipeDetailViewController.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 20/02/2025.
//

import Foundation
import UIKit
import SDWebImage

class RecipeDetailViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setContrainsts()
        self.registerCell()
        self.setupBindings()
        self.viewModel.loadRecipe(recipeId: 1)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Detalles de la Receta"
    }
    private func setContrainsts() {
        self.view.addSubviews(
            self.stackView,
            self.tableView
        )
        self.stackView.addArrangedSubviews(
            self.recipeImageView,
            self.recipeTitleLabel
        )
        
    }
    
    private func registerCell() {
        self.tableView.register(RecipeStepCell.self, forCellReuseIdentifier: RecipeStepCell.identifier)
    }
    
    private func setupBindings() {
        self.viewModel.onRecipeLoaded = { [weak self] in
            guard let self = self, let recipe = viewModel.recipe else
            { return }
            self.recipeTitleLabel.text = recipe.title
            self.recipeImageView.sd_setImage(
                with: URL(
                    string: recipe.image
                ),
                placeholderImage: UIImage(
                    named: "PlaceHolderImage"
                )
            )
            
            self.tableView.reloadData()
        }
        
        self.viewModel.onError = { errorMessage in
            print("Error:", errorMessage)
        }
    }
}

// MARK: - UITableViewDelegate
extension RecipeDetailViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension RecipeDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSteps().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeStepCell.identifier, for: indexPath) as? RecipeStepCell else {
            return UITableViewCell()
        }
        
        let step = viewModel.getSteps()[indexPath.row]
        cell.configure(with: step)
        
        return cell
    }
}
