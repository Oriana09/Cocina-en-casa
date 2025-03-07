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
    
    private let contentView = RecipeDetailView()
    private let viewModel: RecipeDetailViewModel
    
    var recipeId: Int?
    
    init(
        viewModel:  RecipeDetailViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupBindings()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Recipe Details"
        self.contentView.tableView.delegate = self
        self.contentView.tableView.dataSource = self
        self.contentView.tableView.register(
            RecipeStepCell.self,
            forCellReuseIdentifier: RecipeStepCell.identifier
        )
    }
    
    private func setupBindings() {
        guard let recipeId = recipeId else {
            self.showAlertAndReturn()
            return
        }
        self.viewModel.loadRecipe(recipeId: recipeId)
        
        self.viewModel.onRecipeLoaded = { [weak self] in
            guard let self = self, let recipe = viewModel.recipe else
            { return }
            
            DispatchQueue.main.async {
                self.contentView.updateUI(with: recipe)
            }
        }
        
        self.viewModel.onError = { [weak self] title, description in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }
    
    private func showAlertAndReturn() {
        let alerta = UIAlertController(title: "Error", message: "The recipe could not be loaded because the identifier is missing.", preferredStyle: .alert)
        let accionAceptar = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alerta.addAction(accionAceptar)
        present(alerta, animated: true, completion: nil)
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
