//
//  TvShow.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import Foundation

struct TVShow: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
    let image: PosterImage?
    let genres: [String]
    let summary: String?
    let schedule: AirSchedule
}
