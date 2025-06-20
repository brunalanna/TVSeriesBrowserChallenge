//
//  String+HTMLStripped.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import Foundation

import Foundation

extension String {
    func htmlStripped() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&nbsp;", with: " ")
            .replacingOccurrences(of: "&amp;", with: "&")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
