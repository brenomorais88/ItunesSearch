//
//  MusicDetailsCoordinator.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation

protocol MusicSearchCoordinatorProtocol: AnyObject {
    func showDetail(music: Musics)
}

class MusicSearchCoordinator: Coordinator {
    
    override func didInit() {
        let model = MusicSearchModel(resultsLimit: 50)
        let viewModel = MusicSearchViewModel(delegate: self, model: model)
        self.viewController = MusicSearchViewController(viewModel: viewModel)
    }
}

extension MusicSearchCoordinator: MusicSearchCoordinatorProtocol {
    func showDetail(music: Musics) {
        let model = MusicDetailModel(music: music)
        let viewModel = MusicDetailViewModel(delegate: self, model: model)
        self.viewController = MusicDetailViewController(viewModel: viewModel)
        if let vc = self.viewController {
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
}
