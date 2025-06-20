//
//  NetworkService.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(_ request: TVMazeRequest, as type: T.Type) async throws -> T
}

final class DefaultNetworkService: NetworkService {
    
    private let baseURL = URL(string: "https://api.tvmaze.com")!
    
    func request<T: Decodable>(_ request: TVMazeRequest, as type: T.Type) async throws -> T {
        do {
            let urlRequest = try request.makeURLRequest(baseURL: baseURL)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.invalidResponse
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingFailed(error)
            }
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
