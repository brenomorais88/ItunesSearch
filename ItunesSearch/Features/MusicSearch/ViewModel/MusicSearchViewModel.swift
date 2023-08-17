//
//  MusicDetailsViewModel.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation

enum MusicSearchViewState {
    case Loading
    case Data([Musics])
    case Empty
    case Error
    case Warning
}

protocol MusicSearchViewModelProtocol {
    func loadData(term: String)
    func showDetail(music: Musics)
    var viewState: Observable<MusicSearchViewState> { get set }
}

class MusicSearchViewModel: ViewModel, MusicSearchViewModelProtocol {
    let delegate: MusicSearchCoordinatorProtocol
    let model: MusicSearchModel
    let service: ITunesServiceProtocol
    var viewState: Observable<MusicSearchViewState> = Observable(.Loading)
    
    init(delegate: MusicSearchCoordinatorProtocol,
         model: MusicSearchModel,
         service: ITunesServiceProtocol = ITunesService()) {
        self.delegate = delegate
        self.model = model
        self.service = service
        super.init()
    }
    
    func loadData(term: String) {
        if term.isEmpty {
            self.viewState.value = .Warning
            return
        }
        
        self.viewState.value = .Loading
        
        let request = MusicSearchRequest(term: term,
                                         limit: self.model.resultsLimit,
                                         media: .music)
        
        self.service.searchMusicsList(request: request) { success, musics in
            if success {
                guard let musics = musics else { return }
                
                if musics.isEmpty {
                    self.viewState.value = .Empty
                } else {
                    self.viewState.value = .Data(musics)
                }
                
            } else {
                self.viewState.value = .Error
            }
        }
    }
    
    func showDetail(music: Musics) {
        self.delegate.showDetail(music: music)
    }
}
