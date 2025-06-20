//
//  TVShowCardView.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import SwiftUI

struct TVShowCardView: View {
    
    let show: TVShow
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Poster
            AsyncImage(url: show.image?.medium) { phase in
                switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(2/3, contentMode: .fit)
                            .frame(width: 90)
                            .cornerRadius(8)
                    default:
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 90, height: 135)
                            .cornerRadius(8)
                }
            }
            
            // Title + genre + star
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(show.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    if favoritesManager.isFavorite(showID: show.id) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                
                if !show.genres.isEmpty {
                    Text(show.genres.prefix(2).joined(separator: " • "))
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.03), radius: 2, x: 0, y: 1)
        .padding(.horizontal)
        .padding(.vertical, 4) // ✅ espaço entre os blocos
    }
}
