//
//  Episode.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import Foundation

struct Episode: Identifiable, Codable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String?
    let image: PosterImage?
}
