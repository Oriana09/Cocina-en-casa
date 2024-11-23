//
//  ViewController.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 17/11/2024.
//

import UIKit

class SearchViewController: UIViewController{

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
//        layout.minimumInteritemSpacing = 16 // Espacio entre columnas
//        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
//        collection.delegate = self
//        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    let searchController = UISearchController(searchResultsController: nil)
    var netWorkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.registerCell()
        self.setupSearchController()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationItem.title = "cocina en casa"
    }

    private func setupUI() {
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(
                equalTo: self.view.topAnchor
            ),
            self.collectionView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor
            ),
            self.collectionView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor
            ),
            self.collectionView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor
            )
        ])
    }
    
    private func registerCell() {
        self.collectionView.register(SearchCollectionCell.self, forCellWithReuseIdentifier: SearchCollectionCell.identifier)
    }
    
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Escribe el nombre de la receta"
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    
}
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        self.netWorkManager.FetchFoodRecipe(query: self.searchController.searchBar.text ?? "")
    }
    
    
}
