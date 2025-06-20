//
//  AirSchedule.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import Foundation

struct AirSchedule: Decodable, Equatable {
    let time: String
    let days: [String]
}
