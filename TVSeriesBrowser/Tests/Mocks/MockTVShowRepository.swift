//
//  MockTVShowRepository.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import Foundation

final class MockTVShowRepository: TVShowRepositoryProtocol {
    
    var mockShows: [TVShow] = []
    var mockSearchResult: [TVShow] = []
    var shouldFail = false
    
    func fetchAllShows(page: Int) async throws -> [TVShow] {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return mockShows
    }
    
    func searchShows(byName name: String) async throws -> [TVShow] {
        if shouldFail {
            throw URLError(.cannotFindHost)
        }
        return mockSearchResult
    }
    
    func fetchShowDetail(id: Int) async throws -> TVShow {
        fatalError("Not used in this test")
    }
    
    func fetchEpisodes(forShowId id: Int) async throws -> [Episode] {
        fatalError("Not used in this test")
    }
    
    func fetchEpisodeDetail(id: Int) async throws -> Episode {
        fatalError("Not used in this test")
    }
}
