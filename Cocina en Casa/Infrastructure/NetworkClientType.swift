//
//  NetworkClient.swift
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
