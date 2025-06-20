//
//  TVShowDetailView.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import SwiftUI

struct TVShowDetailView: View {
    
    @StateObject private var viewModel: TVShowDetailViewModel
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    
    init(showId: Int) {
        _viewModel = StateObject(wrappedValue: TVShowDetailViewModel(showId: showId))
    }
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Loading details...")
                    .padding()
            } else if let error = viewModel.errorMessage {
                Text("⚠️ \(error)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if let show = viewModel.show {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Poster
                    AsyncImage(url: show.image?.original) { phase in
                        switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(12)
                            default:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 200)
                                    .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Title and Info
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(show.name)
                                .font(.title)
                                .bold()
                            
                            Spacer()
                            
                            Button {
                                favoritesManager.toggleFavorite(showID: show.id)
                            } label: {
                                Image(systemName: favoritesManager.isFavorite(showID: show.id) ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .font(.title2)
                            }
                        }
                        
                        Text("Airs on \(show.schedule.days.joined(separator: ", ")) at \(show.schedule.time)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        if !show.genres.isEmpty {
                            Text("Genres: \(show.genres.joined(separator: ", "))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Summary
                    if let summary = show.summary {
                        Text(summary.htmlStripped())
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    // MARK: - Episodes by Season
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Episodes")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                        
                        ForEach(viewModel.episodesBySeason.keys.sorted(), id: \.self) { season in
                            if let episodes = viewModel.episodesBySeason[season] {
                                DisclosureGroup {
                                    VStack(alignment: .leading, spacing: 8) {
                                        ForEach(episodes) { episode in
                                            NavigationLink(destination: EpisodeDetailView(episodeId: episode.id)) {
                                                VStack(alignment: .leading, spacing: 4) {
                                                    Text("S\(episode.season)E\(episode.number): \(episode.name)")
                                                        .font(.subheadline)
                                                        .foregroundColor(.primary)
                                                    
                                                    if let summary = episode.summary {
                                                        Text(summary.htmlStripped())
                                                            .font(.caption)
                                                            .foregroundColor(.secondary)
                                                            .lineLimit(2)
                                                    }
                                                }
                                                .padding(.vertical, 6)
                                            }
                                        }
                                    }
                                    .padding(.top, 4)
                                } label: {
                                    Text("Season \(season)")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.04), radius: 2, x: 0, y: 1)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.bottom)
                }
                .padding(.top)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.loadDetails()
        }
    }
}
