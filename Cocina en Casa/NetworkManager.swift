//
//  NetworkManager.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 18/11/2024.
//

import Foundation

struct NetworkManager {
    let resultURL = "https://api.spoonacular.com/recipes/complexSearch?apiKey=ab3dfde8ee4644c5ad8904e4b2a2aa8d&number=10"
    
    
    func FetchFoodRecipe(query: String) {
        let urlString = "\(resultURL)&query=\(query)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response,error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let recipe =  self.parseJSON(searchData: safeData) {
                        
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
            print(error)
            return nil
        }
    }
}
