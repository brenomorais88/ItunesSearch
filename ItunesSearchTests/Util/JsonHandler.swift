//
//  JsonHandler.swift
//  HearthstoneCardsTests
//
//  Created by Breno Morais on 04/08/23.
//

import Foundation

import Foundation

class JSONHandler {
    
    func readJson <T: Codable> (type: T.Type, fileName: String) -> T? {
        if let path = Bundle(for: JSONHandler.self).path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let result = try JSONDecoder().decode(type.self, from: data)
                return result
                
            } catch let error {
                print(error)
            }
        }
        return nil
    }
}
