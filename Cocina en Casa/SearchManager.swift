//
//  NetworkManager.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 18/11/2024.
//

import Foundation

protocol SearchManagerDelegate {
    func didUpdateSearchResults(_ results: [Recipe])
    func didFailWithError(title: String, description: String)
}

struct SearchManager {
    let recipeURL = "https://api.spoonacular.com/recipes/complexSearch?apiKey=ab3dfde8ee4644c5ad8904e4b2a2aa8d"
    var delegate: SearchManagerDelegate?
    
    func fetchFoodRecipe(query: String, offset: Int) {
        let urlString = "\(recipeURL)&query=\(query)&number=10&offset=\(offset)"
        self.performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response,error) in
                if error != nil {
                    self.delegate?.didFailWithError(title: "Ocurrió un error", description: error!.localizedDescription)
                    return
                }
                if let safeData = data {
                    if let recipe =  self.parseJSON(searchData: safeData) {
                        self.delegate?.didUpdateSearchResults(recipe)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(searchData: Data)  -> [Recipe]?  {
        let decoder =  JSONDecoder()
        do {
            let decodedData = try decoder.decode(RecipeResponse.self, from: searchData)
            return decodedData.results
        } catch {
            self.delegate?.didFailWithError(title: "Ocurrió un error", description: error.localizedDescription)
            return nil
        }
    }
}
