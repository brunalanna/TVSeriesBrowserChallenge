//
//  TVShowListView.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import SwiftUI

struct TVShowListView: View {
    
    @StateObject private var viewModel = TVShowListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                content
            }
            .navigationTitle("TV Shows")
            .searchable(
                text: $viewModel.searchQuery,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search by name"
            )
            .task {
                await viewModel.loadInitialShows()
            }
        }
    }
    
    private var content: some View {
        Group {
            if viewModel.isLoading && viewModel.shows.isEmpty {
                ProgressView("Loading shows...")
                    .padding()
                Spacer()
            } else if let error = viewModel.errorMessage {
                errorView(message: error)
            } else if viewModel.shows.isEmpty && !viewModel.searchQuery.isEmpty {
                emptyStateView
            } else {
                showList
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.shows)
    }
    
    private var showList: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Trending Now")
                .font(.title2)
                .bold()
                .padding(.horizontal)
                .padding(.top, 8)
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.shows) { show in
                        VStack(spacing: 0) {
                            NavigationLink(destination: TVShowDetailView(showId: show.id)) {
                                TVShowCardView(show: show)
                            }
                            Divider()
                                .padding(.horizontal)
                                .opacity(0.15)
                        }
                        .task {
                            if show == viewModel.shows.last {
                                await viewModel.loadMoreShows()
                            }
                        }
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                            .transition(.opacity)
                    }
                }
                .padding(.bottom)
            }
        }
    }
    
    private func errorView(message: String) -> some View {
        VStack {
            Text("⚠️ \(message)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
            Button("Try Again") {
                Task {
                    await viewModel.loadInitialShows()
                }
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundColor(.gray.opacity(0.5))
                .scaleEffect(1.2)
                .transition(.scale)
            
            Text("No results found")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Try searching with different keywords.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal)
        .padding(.top, 60)
        .frame(maxWidth: .infinity)
    }
}
