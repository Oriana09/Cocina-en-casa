//
//  RecipeDetailView.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 05/03/2025.
//

import Foundation
import UIKit

class RecipeDetailView: UIView {
    
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
    
    private lazy var recipeTitleLabel: UILabel = {
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
    
    private  lazy var servingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkGray
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    private  lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cookingTimeStack, servingsStack])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private  lazy var tableTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Steps"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var  tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setContrainsts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContrainsts() {
        self.addSubviews(
            self.stackView,
            self.infoStack,
            self.tableTitleLabel,
            self.tableView
        )
        
        self.stackView.addArrangedSubviews(
            self.recipeImageView,
            self.recipeTitleLabel
        )
        
        NSLayoutConstraint.activate ([
            self.stackView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            self.stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            
            self.recipeImageView.heightAnchor.constraint(
                equalToConstant: 250
            ),
            self.recipeImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            self.recipeImageView.trailingAnchor.constraint(
                equalTo:  trailingAnchor,
                constant: -16
            ),
            
            self.infoStack.topAnchor.constraint(
                equalTo: self.recipeTitleLabel.bottomAnchor,
                constant: 8
            ),
            self.infoStack.centerXAnchor.constraint(
                equalTo: centerXAnchor
            ),
            
            self.tableTitleLabel.topAnchor.constraint(
                equalTo: self.infoStack.bottomAnchor,
                constant: 16
            ),
            self.tableTitleLabel.centerXAnchor.constraint(
                equalTo:  centerXAnchor
            ),
            
            self.tableView.topAnchor.constraint(
                equalTo: self.tableTitleLabel.bottomAnchor,
                constant: 16
            ),
            self.tableView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            self.tableView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            self.tableView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            )
        ])
    }
    
    func updateUI(with recipe: RecipeDetail) {
        self.recipeTitleLabel.text = recipe.title
        self.recipeImageView.sd_setImage(
            with: URL(
                string: recipe.image
            ),
            placeholderImage: UIImage(
                named: "PlaceHolderImage"
            ),
            options: [.highPriority, .scaleDownLargeImages],
            context: nil
            
        )
        self.cookingTimeLabel.text = "Time \(recipe.readyInMinutes)'"
        self.servingsLabel.text = "Servings \(recipe.servings)"
        self.tableView.reloadData()
        self.animate()
    }
    
    private func animate() {
        self.cookingTimeLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.servingsLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.cookingTimeIcon.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.servingsIcon.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.cookingTimeLabel.alpha = 1
            self.servingsLabel.alpha = 1
            self.cookingTimeIcon.alpha  = 1
            self.servingsIcon.alpha = 1
            self.tableTitleLabel.alpha = 1
            
            self.cookingTimeLabel.transform = .identity
            self.servingsLabel.transform = .identity
            self.cookingTimeIcon.transform = .identity
            self.servingsIcon.transform = .identity
        })
        
        self.cookingTimeIcon.addSymbolEffect(.scale, animated: true)
        self.servingsIcon.addSymbolEffect(.scale, animated: true)
    }
}
