//
//  MusicDetailsViewModel.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation

enum MusicSearchViewState {
    case Loading
    case Data//([Result])
    case Empty
    case Error
}

class MusicSearchViewModel: ViewModel {
    let delegate: MusicSearchCoordinatorProtocol
    let model: MusicSearchModel
    
    init(delegate: MusicSearchCoordinatorProtocol,
         model: MusicSearchModel) {
        
        self.delegate = delegate
        self.model = model
        super.init()
    }
    
    var viewState: Observable<MusicSearchViewState> = Observable(.Loading)
    
    func loadData() {
        
    }
}
