//
//  DefaultNetworkClient.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 17/01/2025.
//

import Foundation

protocol NetworkClientType {
    func performRequest<T: Decodable>(
        endpoint: String,
        parameters: [String: String]?
    ) async throws -> T
}


final class NetworkClient: NetworkClientType {
    private let urlSession: URLSession
    
    init( urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func performRequest<T>(endpoint: String, parameters: [String : String]?) async throws -> T where T : Decodable {
        
        guard var  urlComponents = URLComponents(string:  endpoint) else {
            throw NetworkError.invalidURL
        }
        if let parameters = parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.unexpectedStatusCode((response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}




