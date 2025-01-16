//
//  RecipeError.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 16/01/2025.
//

import Foundation

enum RecipeError: Error {
    
    case invalidQuery // La consulta está vacía o no es válida.
    case noResultsFound // No se encontraron recetas
    case networkError// Problemas con la conexión.
    case serverError // Error en el servidor (500, 404, etc.).
    case decodingError  // Error al decodificar datos.
    case unknown // Error desconocido.
    
    var localizedDescription: String {
        switch self {
        case .invalidQuery:
            return "The query entered is not valid."
        case .noResultsFound:
            return "No recipes were found for this query."
        case .networkError:
            return "There was a problem with the internet connection. Please try again."
        case .serverError:
            return "The server did not respond correctly. Please try again later."
        case .decodingError:
            return "An error occurred while processing the data. Please try again later."
        case .unknown:
            return  "An unknown error occurred. Please try again later."
        }
    }
}
