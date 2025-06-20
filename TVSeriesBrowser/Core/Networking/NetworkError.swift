//
//  NetworkError.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "Invalid URL."
            case .requestFailed(let error):
                return "Request failed: \(error.localizedDescription)"
            case .invalidResponse:
                return "Invalid response from server."
            case .decodingFailed(let error):
                return "Failed to decode response: \(error.localizedDescription)"
        }
    }
}
