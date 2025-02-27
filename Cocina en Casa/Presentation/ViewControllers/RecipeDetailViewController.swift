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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var recipeImageView: UIImageView = {
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
    private lazy var cookingTimeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cookingTimeIcon, cookingTimeLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var cookingTimeIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "clock"))
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    private lazy var cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkGray
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    private lazy var servingsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [servingsIcon, servingsLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var servingsIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.2"))
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var servingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkGray
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cookingTimeStack, servingsStack])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var recipeId: Int?
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
        
        //        / Reducimos temporalmente los labels y los íconos para simular la animación de escala
        self.cookingTimeLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.servingsLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.cookingTimeIcon.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.servingsIcon.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                // Hacemos visibles todos los elementos y les aplicamos la escala normal
                self.cookingTimeLabel.alpha = 1
                self.servingsLabel.alpha = 1
                self.cookingTimeIcon.alpha  = 1
                self.servingsIcon.alpha = 1
                
                self.cookingTimeLabel.transform = .identity
                self.servingsLabel.transform = .identity
                self.cookingTimeIcon.transform = .identity
                self.servingsIcon.transform = .identity
            })
            
            // Aplicamos el efecto de escala a los íconos al mismo tiempo
            self.cookingTimeIcon.addSymbolEffect(.scale, animated: true)
            self.servingsIcon.addSymbolEffect(.scale, animated: true)
        }
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Recipe Details"
    }
    private func setContrainsts() {
        self.view.addSubviews(
            self.stackView,
            self.tableView,
            self.infoStack
        )
        self.stackView.addArrangedSubviews(
            self.recipeImageView,
            self.recipeTitleLabel
        )
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            self.recipeImageView.heightAnchor.constraint(equalToConstant: 250),
            self.recipeImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.recipeImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            self.infoStack.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 8),
            self.infoStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            self.tableView.topAnchor.constraint(equalTo: self.infoStack.bottomAnchor, constant: 16),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
    
    private func registerCell() {
        self.tableView.register(RecipeStepCell.self, forCellReuseIdentifier: RecipeStepCell.identifier)
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
            self.recipeTitleLabel.text = recipe.title
            self.recipeImageView.sd_setImage(
                with: URL(
                    string: recipe.image
                ),
                placeholderImage: UIImage(
                    named: "PlaceHolderImage"
                )
            )
            self.cookingTimeLabel.text = "Tiempo \(recipe.readyInMinutes)'"
            self.servingsLabel.text = "Porciones \(recipe.servings)"
            
            self.tableView.reloadData()
        }
        
        self.viewModel.onError = { errorMessage in
            print("Error:", errorMessage)
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
