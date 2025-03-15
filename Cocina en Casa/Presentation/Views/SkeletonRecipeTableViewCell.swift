//
//  SkeletonRecipeTableViewCell.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 08/03/2025.
//

import Foundation
import UIKit


class SkeletonRecipeTableViewCell: UITableViewCell {
    
    static let identifier = "SkeletonRecipeTableViewCell"
    
    private  lazy var viewImage: UIView = {
        let viewImage = UIView()
        viewImage.backgroundColor = UIColor(white: 0.85, alpha: 1)
        viewImage.layer.cornerRadius = 8
        viewImage.layer.masksToBounds = true
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        return viewImage
    }()
    
    private lazy var viewLabel: UIView = {
        let viewLabel = UIView()
        viewLabel.backgroundColor = UIColor(white: 0.85, alpha: 1)
        viewLabel.layer.cornerRadius = 8
        viewLabel.layer.masksToBounds = true
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        return viewLabel
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
            self.viewImage,
            self.viewLabel
        )
        NSLayoutConstraint.activate([
            
            self.viewImage.topAnchor.constraint(
                equalTo: self.contentView.topAnchor,
                constant: 8
            ),
            self.viewImage.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: 8
            ),
            self.viewImage.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor,
                constant: -8
            ),
            self.viewImage.heightAnchor.constraint(
                equalTo: self.contentView.widthAnchor,
                multiplier: 0.5
            ),
            
            self.viewLabel.topAnchor.constraint(
                equalTo:  self.viewImage.bottomAnchor,
                constant: 8
            ),
            self.viewLabel.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: 8
            ),
            self.viewLabel.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor,
                constant: -8
            ),
            self.viewLabel.heightAnchor.constraint(
                equalToConstant: 20
            ),
            self.viewLabel.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor,
                constant: -8
            )
        ])
    }
    
    func startAnimation() {
        UIView.animateKeyframes(withDuration: 1.2, delay: 0, options: [.repeat, .autoreverse]) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.viewImage.alpha = 0.5
                self.viewLabel.alpha = 0.5
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.viewImage.alpha = 1.0
                self.viewLabel.alpha = 1.0
            }
        }
    }
}

