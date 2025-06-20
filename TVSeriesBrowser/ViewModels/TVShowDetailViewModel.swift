//
//  TVShowDetailViewModel.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//


import Foundation

@MainActor
final class TVShowDetailViewModel: ObservableObject {
    
    @Published private(set) var show: TVShow?
    @Published private(set) var episodesBySeason: [Int: [Episode]] = [:]
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: TVShowRepositoryProtocol
    private let showId: Int
    
    init(showId: Int, repository: TVShowRepositoryProtocol = DefaultTVShowRepository()) {
        self.showId = showId
        self.repository = repository
    }
    
    func loadDetails() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                async let showTask = repository.fetchShowDetail(id: showId)
                async let episodesTask = repository.fetchEpisodes(forShowId: showId)
                
                let (fetchedShow, fetchedEpisodes) = try await (showTask, episodesTask)
                show = fetchedShow
                
                episodesBySeason = Dictionary(grouping: fetchedEpisodes, by: { $0.season })
            } catch {
                errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
    }
}
