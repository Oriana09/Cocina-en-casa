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
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collection.showsHorizontalScrollIndicator = false
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchManager = SearchManager()
    var listOfRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.registerCell()
        self.setupSearchController()
        self.searchManager.delegate = self
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationItem.title = "cocina en casa"
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 350.0, height: 350.0)
    }
}
    // MARK: - UICollectionViewDataSource
    extension SearchViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.listOfRecipes.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionCell.identifier, for: indexPath) as! SearchCollectionCell
            cell.configure(with: self.listOfRecipes[indexPath.row])
            return cell
        }
        
        
    }
    
    //// MARK: - UICollectionViewDelegate
    //extension SearchViewController: UICollectionViewDelegate {
    //
    //}
    
    
    
    // MARK: - UISearchResultsUpdating
    extension SearchViewController: UISearchResultsUpdating {
        func updateSearchResults(for searchController: UISearchController) {
            
            self.searchManager.FetchFoodRecipe(query: self.searchController.searchBar.text ?? "")
        }
    }
    // MARK: - SearchManagerDelegate
    extension SearchViewController: SearchManagerDelegate {
        func didFailWithError(title: String, description: String) {
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        func didUpdateSearchResults(_ results: [Recipe]) {
            
            DispatchQueue.main.async {
                self.listOfRecipes = results
                self.collectionView.reloadData()
            }
        }
        
        
    }

