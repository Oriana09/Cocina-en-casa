//
//  ArticleSearchRouter.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 07/12/2024.
//

import Foundation
import UIKit

class ArticleSearchRouter {
    
    private weak var navigationViewController: UINavigationController?
    init(navigationViewController: UINavigationController?) {
        self.navigationViewController = navigationViewController
    }
    func showSearch(
        _ delegate: UISearchControllerDelegate,
        _ searchBarDelegate: UISearchBarDelegate,
        _ searchTextFieldDelegate: UISearchTextFieldDelegate
    ) {
        
        let searchResultViewController = RecipeCollectionViewController()
        let searchVC = SearchArticleController(searchResultsController: searchResultViewController)
        
        searchVC.automaticallyShowsSearchResultsController = false
        
        searchVC.delegate = delegate
        searchVC.searchBar.searchTextField.delegate = searchTextFieldDelegate
        searchVC.searchBar.placeholder = "Buscar receta"
//        searchVC.searchBar.tintColor = .red
//        searchVC.searchBar.barTintColor = ColorManager.light_neutral_1_dark_neutral_100
        searchVC.searchBar.delegate = searchBarDelegate
        searchVC.searchBar.isTranslucent = false
        searchVC.hidesNavigationBarDuringPresentation = true
        
//        self.navigationViewControllerna?.navigationItem.searchController = searchVC
        self.navigationViewController?.viewControllers.first?.present(
            searchVC,
            animated: true
        )
    }
}
