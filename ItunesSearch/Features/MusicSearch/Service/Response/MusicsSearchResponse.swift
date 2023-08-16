//
//  MusicsSearchResponse.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation

struct MusicsSearchResponse: Codable {
    let resultCount: Int?
    let musics: [Musics]
    
    private enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case musics = "results"
    }
}

struct Musics: Codable {
    let collectionName: String?
    
    private enum CodingKeys: String, CodingKey {
        case collectionName = "collectionName"
    }
}
