//
//  EpisodeDetailView.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//


import SwiftUI

struct EpisodeDetailView: View {
    
    @StateObject private var viewModel: EpisodeDetailViewModel
    
    init(episodeId: Int) {
        _viewModel = StateObject(wrappedValue: EpisodeDetailViewModel(episodeId: episodeId))
    }
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Loading episode...")
                    .padding()
            } else if let error = viewModel.errorMessage {
                Text("⚠️ \(error)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if let episode = viewModel.episode {
                VStack(alignment: .leading, spacing: 16) {
                    if let imageURL = episode.image?.original {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: .infinity)
                                default:
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(height: 200)
                            }
                        }
                    }
                    
                    Text(episode.name)
                        .font(.title)
                        .bold()
                    
                    Text("Season \(episode.season), Episode \(episode.number)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    if let summary = episode.summary {
                        Text(summary.htmlStripped())
                            .font(.body)
                            .padding(.top, 4)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Episode")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadEpisode()
        }
    }
}
