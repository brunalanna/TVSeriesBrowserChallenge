//
//  DefaultNetworkService.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import Foundation

final class DefaultTVShowRepository: TVShowRepositoryProtocol {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }
    
    func fetchAllShows(page: Int) async throws -> [TVShow] {
        try await networkService.request(
            TVMazeAPIRequest.allShows(page: page),
            as: [TVShow].self
        )
    }
    
    func searchShows(byName name: String) async throws -> [TVShow] {
        let rawResults = try await networkService.request(
            TVMazeAPIRequest.searchShows(query: name),
            as: [TVShowSearchResult].self
        )
        return rawResults.map(\.show)
    }
    
    func fetchShowDetail(id: Int) async throws -> TVShow {
        try await networkService.request(
            TVMazeAPIRequest.showDetail(id: id),
            as: TVShow.self
        )
    }
    
    func fetchEpisodes(forShowId id: Int) async throws -> [Episode] {
        try await networkService.request(
            TVMazeAPIRequest.episodesForShow(id: id),
            as: [Episode].self
        )
    }
    
    func fetchEpisodeDetail(id: Int) async throws -> Episode {
        try await networkService.request(
            TVMazeAPIRequest.episodeDetail(id: id),
            as: Episode.self
        )
    }
}
