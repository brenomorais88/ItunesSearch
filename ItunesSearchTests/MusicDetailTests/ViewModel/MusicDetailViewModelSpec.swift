//
//  MusicDetailViewModelSpec.swift
//  ItunesSearchTests
//
//  Created by Breno Morais on 17/08/23.
//

import Foundation
import XCTest
@testable import ItunesSearch

class MusicDetailViewModelSpec: XCTestCase {
    var model: MusicDetailModel?
    var viewModel: MusicDetailViewModel?
    
    override func setUp() {
        guard let music = mockMusic() else {
            XCTFail()
            return
        }
        model = MusicDetailModel(music: music)
        
        guard let model = self.model else {
            XCTFail()
            return
        }
        
        viewModel = MusicDetailViewModel(delegate: self,
                                         model: model)
    }
    
    func testClassInitializers() {
        XCTAssertNotNil(self.viewModel)
        XCTAssertNotNil(self.model)
    }
    
    func testViewControllerInitializer() {
        XCTAssertEqual(self.viewModel?.viewTitle(), "You And Your Heart")
    }
    
    private func mockMusic() -> Musics? {
        if let responseMock = JSONHandler().readJson(type: Musics.self, fileName: "Music") {
            return responseMock
        } else {
            return nil
        }
    }
}

extension MusicDetailViewModelSpec: MusicSearchCoordinatorProtocol {
    func showDetail(music: ItunesSearch.Musics) {}
}

