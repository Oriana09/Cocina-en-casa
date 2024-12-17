//
//  RecipeCollectionView.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 06/12/2024.
//

import UIKit

class RecipeCollectionViewController: UIViewController {
    
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

    
    private let viewModel: RecipeSearchViewModel

    
    init(
        viewModel: RecipeSearchViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.registerCell()
//        self.searchManager.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.setupBindings()
    }
    
    private func configureCollectionView() {
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
        self.collectionView.register(RecipeCollectionCell.self, forCellWithReuseIdentifier: RecipeCollectionCell.identifier)
    }
    
    private func setupBindings() {
        self.viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        self.viewModel.onError = { [weak self] title, description in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }
}
// MARK: - UICollectionViewDelegate
extension RecipeCollectionViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            self.viewModel.loadMoreData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension RecipeCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionCell.identifier, for: indexPath) as! RecipeCollectionCell
        cell.configure(with: self.viewModel.recipes[indexPath.row])
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension RecipeCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 350.0, height: 350.0)
    }
}
//extension RecipeCollectionViewController: RecipeSeachProtocol {
//    func updateSearch() {
//        self.viewModel.result()
//    }
//}
