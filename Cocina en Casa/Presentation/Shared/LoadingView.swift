//
//  LoadingView.swift.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 17/03/2025.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(self.activityIndicator)
        
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func show(in view: UIView) {
        if superview == nil {
            view.addSubview(self)
            NSLayoutConstraint.activate([
                self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                self.widthAnchor.constraint(equalToConstant: 100),
                self.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
        
        self.activityIndicator.startAnimating()
    }
    
    func hide() {
        self.activityIndicator.stopAnimating()
        removeFromSuperview()
    }
}


