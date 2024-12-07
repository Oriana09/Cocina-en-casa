//
//  RecipeCollectionView.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 06/12/2024.
//

import UIKit

class RecipeCollectionView: UIViewController {
    
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
    var searchManager = SearchManager()
    
    var listOfRecipes: [Recipe] = []
    var offset = 10
    var username: String = ""
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.registerCell()
        self.searchManager.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    private func configureCollectionView() {
        self.view.addSubview(self.collectionView)
//        NSLayoutConstraint.activate([
//            self.collectionView.topAnchor.constraint(
//                equalTo: self.view.topAnchor
//            ),
//            self.collectionView.leadingAnchor.constraint(
//                equalTo: self.view.leadingAnchor
//            ),
//            self.collectionView.trailingAnchor.constraint(
//                equalTo: self.view.trailingAnchor
//            ),
//            self.collectionView.bottomAnchor.constraint(
//                equalTo: self.view.bottomAnchor
//            )
//        ])
    }
    
    private func registerCell() {
        self.collectionView.register(RecipeCollectionCell.self, forCellWithReuseIdentifier: RecipeCollectionCell.identifier)
    }
}
// MARK: - UICollectionViewDelegate
extension RecipeCollectionView: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            
            offset += 10
            self.searchManager.fetchFoodRecipe(query: username, offset: offset)
            
        }
    }
}

// MARK: - UICollectionViewDataSource
extension RecipeCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listOfRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionCell.identifier, for: indexPath) as! RecipeCollectionCell
        cell.configure(with: self.listOfRecipes[indexPath.row])
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension RecipeCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 350.0, height: 350.0)
    }
}
//MARK: - SearchManagerDelegate
extension RecipeCollectionView: SearchManagerDelegate {
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
            self.listOfRecipes.append(contentsOf: results)
            self.collectionView.reloadData()
        }
    }
}

