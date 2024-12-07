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
    var onSearchTextChanged: ((String?) -> Void)?
    
    var searchText: String? {
        didSet {
            onSearchTextChanged?(self.searchText)
        }
    }
    init(
        searchText: String? = nil,
        router: ArticleSearchRouter
    ) {
        self.searchText = searchText
        self.router = router
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
}
