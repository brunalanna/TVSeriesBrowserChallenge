//
//  TVShowRepositoryProtocol.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import Foundation

protocol TVShowRepositoryProtocol {
    func fetchAllShows(page: Int) async throws -> [TVShow]
    func searchShows(byName name: String) async throws -> [TVShow]
    func fetchShowDetail(id: Int) async throws -> TVShow
    func fetchEpisodes(forShowId id: Int) async throws -> [Episode]
    func fetchEpisodeDetail(id: Int) async throws -> Episode
}
