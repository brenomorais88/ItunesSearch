//
//  Coordinator.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation

class Service {
    let baseURL: String = "https://itunes.apple.com/"
    let decoder = JSONDecoder()
    
//    let headers: HTTPHeaders = [
//        "Content-Type": "application/json"
//    ]
    
    init() {
        
    }
}

enum APIError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
    case badURL(String)
}
