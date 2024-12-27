//
//  RecipeSearchViewController.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 03/12/2024.
//

import Foundation
import UIKit

class MainSearchViewController: UIViewController, UISearchTextFieldDelegate {
    
    private var currentSearchViewController: UISearchController? {
        return self.presentedViewController as? UISearchController
    }
    
    private var viewModel: RecipeSearchViewModel
    
    init(
        viewModel: RecipeSearchViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.tintColor = .label
        searchBar.placeholder = "Que hay en tu heladera?"
        searchBar.minimumContentSizeCategory = .large
        searchBar.maximumContentSizeCategory = .large
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.configureSearchBarView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDefaultThemeHeader()
//          self.configureViewModel()
     
    }
    
    func configureViewModel() {
        self.viewModel.onSearchTextChanged = { [weak self] text in
            guard let resultVC = self?.currentSearchViewController?.searchResultsController as? RecipeCollectionViewController else {
                return
            }
//            resultVC.updateSearch()
        }
    }
    
//    private lazy var searchResultViewController: RecipeCollectionViewController = {
    //        let navController = self.navigationController
    //        let router = ArticleSearchRouter(
    //            navigationViewController: navController
    //        )
    //        let viewModel = RecipeSearchViewModel(router: router)
    //        let viewController = RecipeCollectionViewController(
    //            viewModel: viewModel
    //        )
    //
    //        return viewController
    //    }()
    
    func configureDefaultThemeHeader() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.titleView = nil
        self.title =  "Buscar"
    }
    
    private func configureSearchBarView() {
        self.view.addSubview(self.searchBarView)
        
        self.searchBarView.setContentCompressionResistancePriority(.required, for: .vertical)
        self.searchBarView.setContentHuggingPriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            self.searchBarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24.0),
            self.searchBarView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24.0),
            self.searchBarView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24.0)
        ])
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancelar"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .label
    }
    
    func navigateToSearchController() {
        let searchController = RecipeCollectionViewController(viewModel: RecipeSearchViewModel())
        navigationController?.pushViewController(searchController, animated: true)
    }
}

extension MainSearchViewController: UISearchBarDelegate {
    
//    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//        if self.searchBarView == searchBar {
//            self.definesPresentationContext = true
//            self.searchBarView.isHidden = true
//            
//            return false
//        }
//        return true
//    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.navigateToSearchController()
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        self.currentSearchViewController?.showsSearchResultsController = false
//    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let currentSearchViewController = self.currentSearchViewController else { return }
//        guard currentSearchViewController.searchBar == searchBar else { return }
//        guard let searchText = searchBar.searchTextField.text else { return }
//
//        // Actualiza el texto de búsqueda en el ViewModel
// 
//        self.viewModel.nameRecipe = searchText
//        
//        // Llama al resultado para ejecutar la búsqueda
//        self.viewModel.result()
//
//        // Actualiza los resultados en el controlador de resultados
//        if let resultVC = currentSearchViewController.searchResultsController as? RecipeCollectionViewController {
////            resultVC.updateSearch()
//        }
//        
//        self.currentSearchViewController?.showsSearchResultsController = true
//    }
//    
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = ""
//        
//        // Ocultar el teclado
//        searchBar.resignFirstResponder()
//        
//        // Ocultar los resultados de búsqueda (si es necesario)
//        self.currentSearchViewController?.showsSearchResultsController = false
//        
//        // Limpiar el texto de búsqueda en el ViewModel
//        self.viewModel.nameRecipe = ""
//    }
}
extension  MainSearchViewController: UISearchControllerDelegate {
    func willDismissSearchController(_ searchController: UISearchController) {
        self.searchBarView.isHidden = false
    }
}