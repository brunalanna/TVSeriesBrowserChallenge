//
//  TVShowListViewModel.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import Foundation

@MainActor
final class TVShowListViewModel: ObservableObject {
    
    @Published private(set) var shows: [TVShow] = []
    @Published private(set) var isLoading: Bool = false
    @Published var searchQuery: String = ""
    @Published var errorMessage: String?
    
    private let repository: TVShowRepositoryProtocol
    private var currentPage: Int = 0
    private var canLoadMorePages = true
    private var isSearching = false
    private var searchTask: Task<Void, Never>? = nil
    
    init(repository: TVShowRepositoryProtocol = DefaultTVShowRepository()) {
        self.repository = repository
        observeSearchQuery()
    }
    
    func loadInitialShows() async {
        currentPage = 0
        shows = []
        canLoadMorePages = true
        isSearching = false
        await loadMoreShows()
    }
    
    func loadMoreShows() async {
        guard !isLoading, canLoadMorePages, !isSearching else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let nextPage = currentPage + 1
            let newShows = try await repository.fetchAllShows(page: nextPage)
            
            if newShows.isEmpty {
                canLoadMorePages = false
            } else {
                currentPage = nextPage
                shows += newShows
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func searchShows() async {
        guard !searchQuery.isEmpty else {
            await loadInitialShows()
            return
        }
        
        isLoading = true
        isSearching = true
        errorMessage = nil
        
        do {
            let results = try await repository.searchShows(byName: searchQuery)
            shows = results
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    private func observeSearchQuery() {
        Task {
            for await query in $searchQuery.values {
                searchTask?.cancel()
                
                searchTask = Task {
                    try? await Task.sleep(nanoseconds: 500_000_000) // 0.5s debounce
                    
                    if query.count >= 3 {
                        await searchShows()
                    } else if query.isEmpty {
                        await loadInitialShows()
                    }
                }
            }
        }
    }
}
