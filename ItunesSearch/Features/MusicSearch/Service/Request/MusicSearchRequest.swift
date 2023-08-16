//
//  MusicSearchRequest.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation

struct MusicSearchRequest: Encodable {
    private let term: String
    let limit: Int
    let media: String
    
    init(term: String, limit: Int, media: MediaType) {
        self.term = term
        self.limit = limit
        self.media = media.rawValue
    }
    
    public func getFixedTerm() -> String {
        return term.replacingOccurrences(of: " ", with: "+")
    }
}

enum MediaType: String {
    case music = "music"
}
    
