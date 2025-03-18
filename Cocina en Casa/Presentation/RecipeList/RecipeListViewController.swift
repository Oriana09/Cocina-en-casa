//
//  RecipeCollectionView.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 06/12/2024.
//

import UIKit


class RecipeListViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
   
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    private let viewModel:  RecipeListViewModel
    
    init(
        viewModel:  RecipeListViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Recipes"
        self.view.backgroundColor = .systemBackground
        
        self.setupSearchController()
        self.configureTableView()
        self.registerCell()
        self.setupBindings()
        
    }
    
    
    
    func setupSearchController() {
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Buscar algo..."
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.showsCancelButton = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureTableView() {
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(
                equalTo: self.view.topAnchor
            ),
            self.tableView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor
            ),
            self.tableView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor
            ),
            self.tableView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor
            )
        ])
    }
    
    private func registerCell() {
        self.tableView.register(SkeletonRecipeTableViewCell.self, forCellReuseIdentifier: SkeletonRecipeTableViewCell.identifier)
        self.tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.identifier)
        
        
    }
    
   
    
    private func setupBindings() {
        self.viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        self.viewModel.onError = { [weak self] title, description in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
        self.viewModel.onLoadingStateChanged = { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        self.viewModel.didSelectRecipe = { [weak self] recipeId in
            guard let self = self else { return }
            
            let detailVC = RecipeDetailViewController(viewModel: RecipeDetailViewModel())
            detailVC.recipeId = recipeId
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
// MARK: - UITableViewDelegate

extension RecipeListViewController: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - 50 {
            self.viewModel.loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedRecipeId = viewModel.recipes[indexPath.row].id
        self.viewModel.didSelectRecipe?(selectedRecipeId)
    }
}

// MARK: - UITableViewDataSource

extension RecipeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.isLoading ? 10 : viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if viewModel.isLoading {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "SkeletonRecipeTableViewCell", for: indexPath) as! SkeletonRecipeTableViewCell
            DispatchQueue.main.asyncAfter(
                deadline: .now() + Double(indexPath.row) * 0.3
            ) {
                cell.startAnimation()
            }
            
            return cell
        } else {
            let recipe = viewModel.recipes[indexPath.row]
            let cell =  tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
            
            cell.configure(with: recipe)
            return cell
            
        }
    }
}

// MARK: - UISearchBarDelegate
extension RecipeListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        self.viewModel.searchRecipes(query: query)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.searchRecipes(query: "")
        
        searchBar.text = ""
        
        self.tableView.reloadData()
    }
}

