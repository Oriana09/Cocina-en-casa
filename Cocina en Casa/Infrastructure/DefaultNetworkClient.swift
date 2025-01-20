//
//  DefaultNetworkClient.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 17/01/2025.
//

import Foundation

final class DefaultNetworkClient: NetworkClient {
    private let baseURL = "https://api.spoonacular.com/"
    private let urlSession: URLSession
    
    init( urlSession: URLSession = .shared) {
//        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    
    func performRequest<T>(endpoint: String, parameters: [String : String]?) async throws -> T where T : Decodable {
        // Construcción de la URL con parámetros
        guard var  urlComponents = URLComponents(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        if let parameters = parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        // Asegurarse de que la URL final sea válida
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        // Configuración de la solicitud
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Ejecución de la solicitud
        let (data, response) = try await urlSession.data(for: request)
        
        // Verificación del estado HTTP
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.unexpectedStatusCode((response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        // Decodificación del resultado
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}




