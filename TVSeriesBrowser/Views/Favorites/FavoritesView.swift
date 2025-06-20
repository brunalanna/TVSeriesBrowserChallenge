//
//  FavoritesView.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//


import SwiftUI

struct FavoritesView: View {
    
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    @State private var favoriteShows: [TVShow] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    private let repository: TVShowRepositoryProtocol = DefaultTVShowRepository()
    
    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView("Loading favorites...")
                        .padding()
                } else if let error = errorMessage {
                    Text("⚠️ \(error)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if favoriteShows.isEmpty {
                    Text("You have no favorite shows yet.")
                        .foregroundColor(.secondary)
                        .padding(.top, 80)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(favoriteShows) { show in
                                NavigationLink(destination: TVShowDetailView(showId: show.id)) {
                                    TVShowCardView(show: show)
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                loadFavorites()
            }
        }
    }
    
    private func loadFavorites() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                let ids = favoritesManager.favoriteShowIDs
                var shows: [TVShow] = []
                
                for id in ids {
                    let show = try await repository.fetchShowDetail(id: id)
                    shows.append(show)
                }
                
                favoriteShows = shows
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
