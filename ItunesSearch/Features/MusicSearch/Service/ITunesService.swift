//
//  MusicDetailsService.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation

protocol ITunesServiceProtocol {
    func searchMusicsList(request: MusicSearchRequest, callback: @escaping (Bool, [Musics]?) -> ())
}

class ITunesService: Service, ITunesServiceProtocol {
    
    func searchMusicsList(request: MusicSearchRequest, callback: @escaping (Bool, [Musics]?) -> ()) {
        let term = request.term
        let limit = request.limit
        
        guard let url = URL(string: "\(self.baseURL)search?term=\(term)&limit=\(limit)") else {
            callback(false, nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                callback(false, nil)
                return
            }
            
            if error != nil {
                callback(false, nil)
            }
            
            do {
                let parsedData = try self.decoder.decode(MusicsSearchResponse.self,
                                                         from: data)
                callback(true, parsedData.musics)
                
            } catch {
                callback(false, nil)
            }
        }
        task.resume()
    }
}
