//
//  ViewController.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 17/11/2024.
//

import UIKit

class RecipeSearchResultViewController: UIViewController {
    
    private var searchResultViewController = RecipeCollectionView()
    
    private weak var searchResultViewControllerTopAnchor: NSLayoutConstraint?
    
    var searchManager = SearchManager()
    var searchText: String = ""
    
//    override func loadView() {
//        super.loadView()
//        self.view.backgroundColor = .white
//        self.configureRecipe()
//    }
    init(navigationController: UINavigationController) {
        super.init(nibName: nil, bundle: nil)
        let searchResultViewController = RecipeCollectionView()
        self.searchResultViewController = searchResultViewController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.configureRecipe()
    }
    
    private func configureRecipe() {
        self.addChild(self.searchResultViewController)
       
        
        self.searchResultViewController.view.frame = self.view.bounds
            self.searchResultViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      
        self.view.addSubview(self.searchResultViewController.view)
     
        self.searchResultViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let searchResultViewControllerTopAnchor  =
        self.searchResultViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 56.0)
        
        self.searchResultViewControllerTopAnchor = searchResultViewControllerTopAnchor
        
        NSLayoutConstraint.activate([
            searchResultViewControllerTopAnchor,
            self.view.trailingAnchor.constraint(equalTo: self.searchResultViewController.view.trailingAnchor),
            self.view.leadingAnchor.constraint(equalTo: self.searchResultViewController.view.leadingAnchor),
            self.view.bottomAnchor.constraint(equalTo: self.searchResultViewController.view.bottomAnchor)
        ])
        
        self.searchResultViewController.didMove(toParent: self)
    }
  
    func updateSearch() {
        self.searchManager.fetchFoodRecipe(query: searchText, offset: 0)
    }
    
    
}
