//
//  TVMazeAPIRequest.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import Foundation

enum TVMazeAPIRequest: TVMazeRequest {
    case allShows(page: Int)
    case searchShows(query: String)
    case showDetail(id: Int)
    case episodesForShow(id: Int)
    case episodeDetail(id: Int)
    
    var path: String {
        switch self {
            case .allShows: return "/shows"
            case .searchShows: return "/search/shows"
            case .showDetail(let id): return "/shows/\(id)"
            case .episodesForShow(let id): return "/shows/\(id)/episodes"
            case .episodeDetail(let id): return "/episodes/\(id)"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
            case .allShows(let page):
                return [URLQueryItem(name: "page", value: String(page))]
            case .searchShows(let query):
                return [URLQueryItem(name: "q", value: query)]
            default:
                return nil
        }
    }
}
