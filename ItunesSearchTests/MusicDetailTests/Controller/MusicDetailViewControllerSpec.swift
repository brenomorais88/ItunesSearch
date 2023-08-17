//
//  MusicDetailViewControllerSpec.swift
//  ItunesSearchTests
//
//  Created by Breno Morais on 17/08/23.
//

import Foundation
import XCTest
@testable import ItunesSearch

class MusicDetailViewControllerSpec: XCTestCase {
    
    var model: MusicDetailModel?
    var viewModel: MusicDetailViewModel?
    var vc: MusicDetailViewController?
    
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
        
        guard let viewModel = self.viewModel else {
            XCTFail()
            return
        }
        
        vc = MusicDetailViewController(viewModel: viewModel)
    }
    
    func testClassInitializers() {
        XCTAssertNotNil(self.model)
        XCTAssertNotNil(self.vc)
        XCTAssertNotNil(self.vc?.viewModel)
    }
    
    func testLoadViewCreation() {
        guard let music = self.mockMusic() else {
            XCTFail("Impossible to decode Music object")
            return
        }
        DispatchQueue.main.async {
            self.vc?.viewModel.viewState.value = .Data(music)
            XCTAssertEqual(self.vc?.view.subviews.count, 2)
            XCTAssertEqual(self.vc?.view.subviews.first?.subviews.count, 2)
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

extension MusicDetailViewControllerSpec: MusicSearchCoordinatorProtocol {
    func showDetail(music: ItunesSearch.Musics) {}
}


