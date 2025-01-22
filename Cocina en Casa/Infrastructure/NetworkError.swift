//
//  NetworkError.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 17/01/2025.
//

import Foundation

enum NetworkError: Error {
    
    case invalidURL
    case requestFailed
    case unexpectedStatusCode(Int)
    case invalidResponse
    case decodingFailed
    case unknown(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .unexpectedStatusCode(let statusCode):
            return "Unexpected response from the server. Status code: \(statusCode)."
        case .decodingFailed:
            return "Failed to decode the server response."
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        case .requestFailed:
            return "The request failed (connection problems)."
        case .invalidResponse:
            return "Invalid or corrupted response"
        }
    }
}
