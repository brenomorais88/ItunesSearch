//
//  MusicDetailViewModel.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation

enum MusicDetailViewState {
    case Data(Musics)
}

protocol MusicDetailViewModelProtocol {
    func showDetails()
    func viewTitle() -> String
    var viewState: Observable<MusicDetailViewState> { get set }
}

class MusicDetailViewModel: ViewModel, MusicDetailViewModelProtocol {
    weak var delegate: MusicSearchCoordinatorProtocol?
    let model: MusicDetailModel
    var viewState: Observable<MusicDetailViewState> = Observable(nil)
    
    init(delegate: MusicSearchCoordinatorProtocol,
         model: MusicDetailModel) {
        self.delegate = delegate
        self.model = model
        super.init()
    }
    
    func showDetails() {
        let music = self.model.music
        self.viewState.value = .Data(music)
    }
    
    func viewTitle() -> String {
        return self.model.music.trackName ?? Strings.kDetailsViewTitle.rawValue
    }
}

