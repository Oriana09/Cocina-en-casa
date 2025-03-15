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
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
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
        self.configureActivityIndicator()
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
    
    private func configureActivityIndicator() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.activityIndicator)
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupBindings() {
        guard let recipeId = recipeId else {
            self.showAlertAndReturn()
            return
        }
        
        self.viewModel.isLoading = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        self.viewModel.onRecipeLoaded = { [weak self] in
            guard let self = self, let recipe = self.viewModel.recipe else { return }
            
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
        
        self.viewModel.loadRecipe(recipeId: recipeId)
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
        return self.viewModel.getSteps().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeStepCell.identifier, for: indexPath) as? RecipeStepCell else {
            return UITableViewCell()
        }
        
        let step = self.viewModel.getSteps()[indexPath.row]
        cell.configure(with: step)
        
        return cell
    }
}
