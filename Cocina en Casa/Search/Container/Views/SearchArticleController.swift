//
//  SearchArticleController.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 07/12/2024.
//

import Foundation
import UIKit

class SearchArticleController: UISearchController {
    
    override var showsSearchResultsController: Bool {
        didSet {
            self.searchBar.layer.borderWidth = showsSearchResultsController ? 1.0 : 0.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.layer.borderColor = UIColor.blue.cgColor
        self.searchBar.minimumContentSizeCategory = .large
        self.searchBar.maximumContentSizeCategory = .large
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let results = self.searchResultsController as! RecipeSearchResultViewController
//        results.updateSearchBar(self.searchBar.size)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.searchBar.layer.borderColor = UIColor.red.cgColor
    }
    
}
