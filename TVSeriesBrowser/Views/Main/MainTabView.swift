//
//  MainTabView.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                TVShowListView()
            }
            .tabItem {
                Label("Discover", systemImage: "sparkles.tv")
            }
            
            NavigationStack {
                FavoritesView()
            }
            .tabItem {
                Label("Favorites", systemImage: "star.fill")
            }
        }
        .tint(.indigo) // ou .teal, .orange, etc
        .background(Color(.systemGroupedBackground)) // melhor contraste em dark/light mode
    }
}
