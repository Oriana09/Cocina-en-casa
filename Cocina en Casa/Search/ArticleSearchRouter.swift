////
////  ArticleSearchRouter.swift
////  Cocina en Casa
////
////  Created by Oriana Costancio on 07/12/2024.
////
//
//import Foundation
//import UIKit
//
//class ArticleSearchRouter {
//    
//    private weak var navigationViewController: UINavigationController?
//    init(navigationViewController: UINavigationController?) {
//        self.navigationViewController = navigationViewController
//    }
//    func showSearch(
//        _ delegate: UISearchControllerDelegate,
//        _ searchBarDelegate: UISearchBarDelegate,
//        _ searchTextFieldDelegate: UISearchTextFieldDelegate
//    ) {
//        
//        let searchResultViewController = RecipeCollectionViewController()
//        let searchVC = SearchArticleController(searchResultsController: searchResultViewController)
//        
//        searchResultViewController.automaticallyShowsSearchResultsController = false
//        
//        searchResultViewController.delegate = delegate
//        searchResultViewController.searchBar.searchTextField.delegate = searchTextFieldDelegate
//        searchResultViewController.searchBar.placeholder = "Buscar receta"
//
//        searchResultViewController.searchBar.delegate = searchBarDelegate
//        searchResultViewController.searchBar.isTranslucent = false
//        searchResultViewController.hidesNavigationBarDuringPresentation = true
//        
//
//        self.navigationViewController?.viewControllers.first?.present(
//            searchVC,
//            animated: true
//        )
//    }
//}
////private lazy var searchResultViewController: RecipeCollectionViewController = {
////           let navController = self.navigationController
////           let router = ArticleSearchRouter(
////               navigationViewController: navController
////           )
////           let viewModel = RecipeSearchViewModel(router: router)
////           let viewController = RecipeCollectionViewController(
////               viewModel: viewModel
////           )
////   
////           return viewController
////       }()
