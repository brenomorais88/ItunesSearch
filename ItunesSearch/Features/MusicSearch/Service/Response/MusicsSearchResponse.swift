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
    let imgURL: String?
    let artistName: String?
    let trackName: String?
    let previewUrl: String?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    private let collectionPrice: Double?
    
    private enum CodingKeys: String, CodingKey {
        case collectionName = "collectionName"
        case imgURL = "artworkUrl100"
        case artistName = "artistName"
        case trackName = "trackName"
        case previewUrl = "previewUrl"
        case collectionPrice = "collectionPrice"
        case country = "country"
        case currency = "currency"
        case primaryGenreName = "primaryGenreName"
    }
    
    func getFormattedValue() -> String {
        return "R$10,99"
    }
}
