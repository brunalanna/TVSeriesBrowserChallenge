//
//  EpisodeDetailViewModel.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//


import Foundation

@MainActor
final class EpisodeDetailViewModel: ObservableObject {
    
    @Published private(set) var episode: Episode?
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: TVShowRepositoryProtocol
    private let episodeId: Int
    
    init(episodeId: Int, repository: TVShowRepositoryProtocol = DefaultTVShowRepository()) {
        self.episodeId = episodeId
        self.repository = repository
    }
    
    func loadEpisode() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetched = try await repository.fetchEpisodeDetail(id: episodeId)
                episode = fetched
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
