//
//  MusicDetailsCoordinator.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation

protocol MusicSearchCoordinatorProtocol {
    
}

class MusicSearchCoordinator: Coordinator {
    
    override func didInit() {
        let model = MusicSearchModel()
        let viewModel = MusicSearchViewModel(delegate: self, model: model)
        self.viewController = MusicSearchViewController(viewModel: viewModel)
    }
}

extension MusicSearchCoordinator: MusicSearchCoordinatorProtocol {
    
}
