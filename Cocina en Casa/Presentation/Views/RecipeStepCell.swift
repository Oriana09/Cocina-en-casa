//
//  RecipeStepCell.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 21/02/2025.
//

import Foundation
import UIKit

class RecipeStepCell: UITableViewCell {
    
    static let identifier = "RecipeStepCell"
    
    private let stepNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stepNumberContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stepDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        self.configureStepNumberContainer()
        self.configureContainerView()
    }
    
    private func configureStepNumberContainer() {
        self.stepNumberContainer.addSubview(stepNumberLabel)
        NSLayoutConstraint.activate([
            self.stepNumberLabel.centerXAnchor.constraint(
                equalTo: self.stepNumberContainer.centerXAnchor
            ),
            self.stepNumberLabel.centerYAnchor.constraint(
                equalTo: self.stepNumberContainer.centerYAnchor
            ),
            
            self.stepNumberContainer.widthAnchor.constraint(
                equalToConstant: 40
            ),
            self.stepNumberContainer.heightAnchor.constraint(
                equalToConstant: 40
            )
        ])
    }
    
    private func configureContainerView() {
        self.horizontalStackView.addArrangedSubviews(
            self.stepNumberContainer,
            self.stepDescriptionLabel
        )
        
        self.containerView.addSubview(self.horizontalStackView)
        self.contentView.addSubview(self.containerView)
        
        NSLayoutConstraint.activate(
            [
                self.containerView.topAnchor.constraint(
                    equalTo: self.contentView.topAnchor,
                    constant: 8
                ),
                self.containerView.leadingAnchor.constraint(
                    equalTo: self.contentView.leadingAnchor,
                    constant: 16
                ),
                self.containerView.trailingAnchor.constraint(
                    equalTo: self.contentView.trailingAnchor,
                    constant: -16
                ),
                self.containerView.bottomAnchor.constraint(
                    equalTo: self.contentView.bottomAnchor,
                    constant: -8
                ),
                
                self.horizontalStackView.topAnchor.constraint(
                    equalTo: self.containerView.topAnchor,
                    constant: 12
                ),
                self.horizontalStackView.leadingAnchor.constraint(
                    equalTo: self.containerView.leadingAnchor,
                    constant: 16
                ),
                self.horizontalStackView.trailingAnchor.constraint(
                    equalTo: self.containerView.trailingAnchor,
                    constant: -16
                ),
                self.horizontalStackView.bottomAnchor.constraint(
                    equalTo: self.containerView.bottomAnchor,
                    constant: -12
                )
            ]
        )
    }
    
    func configure(with step: RecipeDetail.Instruction) {
        self.stepNumberLabel.text = String(step.number)
        self.stepDescriptionLabel.text = step.step
    }
}
