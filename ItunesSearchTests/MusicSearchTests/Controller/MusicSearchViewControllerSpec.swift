//
//  MusicSearchViewControllerSpec.swift
//  ItunesSearchTests
//
//  Created by Breno Morais on 17/08/23.
//

import Foundation
import XCTest
@testable import ItunesSearch

class MusicSearchViewControllerSpec: XCTestCase {
    
    let model = MusicSearchModel(resultsLimit: 10)
    var viewModel: MusicSearchViewModel?
    var vc: MusicSearchViewController?
    
    override func setUp() {
        viewModel = MusicSearchViewModel(delegate: self,
                                         model: model)
        vc = MusicSearchViewController(viewModel: viewModel)
    }
    
    func testClassInitializers() {
        XCTAssertNotNil(self.vc)
        XCTAssertNotNil(self.vc?.viewModel)
    }
    
    func testLoadViewCreation() {
        guard let vc = self.vc else {
            XCTFail()
            return
        }
        DispatchQueue.main.async {
            vc.viewModel?.viewState.value = .Loading
            XCTAssertNotNil(vc.loadingView)
        }
    }
    
    func testEmptyViewCreation() {
        guard let vc = self.vc else {
            XCTFail()
            return
        }
        DispatchQueue.main.async {
            vc.viewModel?.viewState.value = .Empty
            XCTAssertNotNil(vc.errorView)
        }
    }
    
    func testErrorViewCreation() {
        guard let vc = self.vc else {
            XCTFail()
            return
        }
        DispatchQueue.main.async {
            vc.viewModel?.viewState.value = .Error
            XCTAssertNotNil(vc.errorView)
        }
    }
    
    func testDataViewCreation() {
        guard let vc = self.vc else {
            XCTFail()
            return
        }
        DispatchQueue.main.async {
            guard let music = self.mockMusic() else {
                XCTFail("Impossible to decode Music object")
                return
            }
            vc.viewModel?.viewState.value = .Data([music])
            XCTAssertNotNil(vc.resultsView)
        }
    }
    
    private func mockMusic() -> Musics? {
        if let responseMock = JSONHandler().readJson(type: Musics.self, fileName: "Music") {
            return responseMock
        } else {
            return nil
        }
    }
}

extension MusicSearchViewControllerSpec: MusicSearchCoordinatorProtocol {
    func showDetail(music: ItunesSearch.Musics) {}
}

