//
//  MusicSearchViewModelSpec.swift
//  ItunesSearchTests
//
//  Created by Breno Morais on 17/08/23.
//

import Foundation
import XCTest
@testable import ItunesSearch

class ITunesServiceProtocolMock: ITunesServiceProtocol {
    var jsonMock = ""
    var musics: [Musics] = []
    var didCallMusics = false
    var didCallMusicsWithError = false
    
    func searchMusicsList(request: ItunesSearch.MusicSearchRequest, callback: @escaping (Bool, [ItunesSearch.Musics]?) -> ()) {
        if let responseMock = JSONHandler().readJson(type: MusicsSearchResponse.self, fileName: self.jsonMock) {
            self.musics = responseMock.musics
            self.didCallMusics = true
        } else {
            self.musics = []
            self.didCallMusicsWithError = true
        }
    }
}

class MusicSearchViewModelSpec: XCTestCase {
    let model = MusicSearchModel(resultsLimit: 10)
    var viewModel: MusicSearchViewModel?
    let server = ITunesServiceProtocolMock()
    var selectecMusicName = ""
    var musics: [Musics] = []
    
    override func setUp() {
        viewModel = MusicSearchViewModel(delegate: self,
                                         model: model,
                                         service: server)
    }
    
    func testClassInitializers() {
        XCTAssertNotNil(self.viewModel)
    }
    
    func testViewControllerInitializer() {
        XCTAssertEqual(self.viewModel?.model.resultsLimit, 10)
    }
    
    func testMusicSelection() {
        guard let music = mockMusic() else {
            XCTFail("Impossible to decode Music object")
            return
        }
        self.viewModel?.delegate.showDetail(music: music)
        
        XCTAssertEqual(self.selectecMusicName, "You And Your Heart")
    }
    
    func testLoadData() {
        self.server.jsonMock = "MusicResponse"
        self.viewModel?.loadData(term: "test")
        XCTAssertEqual(self.server.musics.count, 15)
        XCTAssertTrue(self.server.didCallMusics)
    }
    
    func testLoadDataEmpty() {
        self.server.jsonMock = "MusicResponseEmpty"
        self.viewModel?.loadData(term: "test")
        XCTAssertEqual(self.server.musics.count, 0)
    }
    
    func testLoadDataError() {
        self.server.jsonMock = "MusicResponseError"
        self.viewModel?.loadData(term: "test")
        XCTAssertEqual(self.server.musics.count, 0)
        XCTAssertTrue(self.server.didCallMusicsWithError)
    }
    
    private func mockMusic() -> Musics? {
        if let responseMock = JSONHandler().readJson(type: Musics.self, fileName: "Music") {
            return responseMock
        } else {
            return nil
        }
    }
}

extension MusicSearchViewModelSpec: MusicSearchCoordinatorProtocol {
    func showDetail(music: ItunesSearch.Musics) {
        self.selectecMusicName = music.trackName ?? ""
    }
}
