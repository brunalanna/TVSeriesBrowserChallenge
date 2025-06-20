//
//  TvShow+Mock.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import Foundation

extension TVShow {
    static func mock(id: Int = 0, name: String = "Mock Show") -> TVShow {
        TVShow(
            id: id,
            name: name,
            image: nil,
            genres: ["Drama"],
            summary: "This is a mock show.",
            schedule: AirSchedule(time: "22:00", days: ["Monday"])
        )
    }
}
