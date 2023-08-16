//
//  MusicSearchRequest.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation

struct MusicSearchRequest: Encodable {
    let term: String
    let limit: Int = 25
}
