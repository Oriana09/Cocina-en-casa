//
//  RecipeSearchViewModel.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 03/12/2024.
//

import Foundation
import UIKit

class RecipeSearchViewModel {
  
    private let router: ArticleSearchRouter
    private var searchManager = SearchManager()
    
    var recipes: [Recipe] = []
    var offNumber = 0
    var offset = 10
    
    var onSearchTextChanged: ((String?) -> Void)?
    var onDataUpdated: (() -> Void)?
    var onError: ((String, String) -> Void)?
 
    var nameRecipe: String? {
        didSet {
            print("🔄 searchText cambiado a: \(nameRecipe ?? "nil")")
            onSearchTextChanged?(self.nameRecipe)
        }
    }
    
    
    init(
        nameRecipe: String? = nil,
        router: ArticleSearchRouter
    ) {
        self.nameRecipe = nameRecipe
        self.router = router
        self.searchManager.delegate = self
    }
    func showSearch(
        _ delegate: UISearchControllerDelegate,
        _ searchBarDelegate: UISearchBarDelegate,
        _ searchTextFieldDelegate: UISearchTextFieldDelegate
    ) {
        self.router.showSearch(
            delegate,
            searchBarDelegate,
            searchTextFieldDelegate
        )
    }
    // Método para manejar la búsqueda
    func result() {
        guard let query = nameRecipe, !query.isEmpty else {
            return
        }
//        print("✅ Ejecutando result() con query: \(query) y offset: \(offNumber)")
        self.searchManager.fetchFoodRecipe(query:  query, offset: offNumber)
    }
    
    //Metodo  para cargar más datos (scroll infinito)
    func loadMoreData() {
        guard let query = nameRecipe, !query.isEmpty else { return }
        offset += 10
        searchManager.fetchFoodRecipe(query: query, offset: offset)
    }
}

extension RecipeSearchViewModel: SearchManagerDelegate {
  
    func didUpdateSearchResults(_ results: [Recipe]) {
        self.recipes.append(contentsOf: results)
        self.onDataUpdated?() // Notificamos a la vista que los datos han cambiado
    }
    
    func didFailWithError(title: String, description: String) {
        self.onError?(title, description) // Notificamos errores
    }
}
