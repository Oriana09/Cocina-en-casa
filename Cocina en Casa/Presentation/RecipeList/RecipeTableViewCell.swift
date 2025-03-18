//
//  SearchTableViewCell.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 22/11/2024.
//

import Foundation
import UIKit
import SDWebImage

class RecipeTableViewCell: UITableViewCell {
    static let identifier = "RecipeTableViewCell"
    
    private lazy var recipeimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.addSubviews(
            self.recipeimageView,
            self.titleLabel
        )
        NSLayoutConstraint.activate([
            self.recipeimageView.topAnchor.constraint(
                equalTo: self.contentView.topAnchor, constant: 8
            ),
            self.recipeimageView.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor, constant: 8
            ),
            self.recipeimageView.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor, constant: -8
            ),
            self.recipeimageView.heightAnchor.constraint(
                equalTo: self.contentView.widthAnchor, multiplier: 0.75
            ),
            
            self.titleLabel.topAnchor.constraint(
                equalTo: self.recipeimageView.bottomAnchor,
                constant: 8
            ),
            self.titleLabel.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor, constant: 8
            ),
            self.titleLabel.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor, constant: -8),
            self.titleLabel.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor, constant: -8
            )
        ])
    }
    
    func configure(with recipe: Recipe) {
        self.recipeimageView.sd_setImage(
            with: URL(string: recipe.image),
            placeholderImage: UIImage(named: "PlaceHolderImage"),
            options: [.highPriority, .scaleDownLargeImages],
            context: nil
        )
        self.titleLabel.text = recipe.title
    }
}



