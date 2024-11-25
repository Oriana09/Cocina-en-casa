//
//  SearchTableViewCell.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 22/11/2024.
//

import Foundation
import UIKit
import SDWebImage

class SearchCollectionCell: UICollectionViewCell {
    static let identifier = "SearchCollectionCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.addSubviews(
            self.imageView,
            self.titleLabel
        )
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(
                equalTo: self.contentView.topAnchor
            ),
            self.imageView.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor
            ),
            self.imageView.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor
            ),
            self.imageView.heightAnchor.constraint(
                equalTo: self.contentView.widthAnchor
            ),
            
            self.titleLabel.topAnchor.constraint(
                equalTo: self.imageView.bottomAnchor,
                constant: 8
            ),
            self.titleLabel.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor
            ),
            self.titleLabel.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor)
            ,
        ])
    }
    
    func configure(with recipe: Recipe) {
        self.imageView.sd_setImage(
            with: URL(string: recipe.image),
                placeholderImage: UIImage(named: "placeHolder")
            )
    }
}
