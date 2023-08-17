//
//  MusicDetailViewSpec.swift
//  ItunesSearchTests
//
//  Created by Breno Morais on 17/08/23.
//

import Foundation
import XCTest
@testable import ItunesSearch

class MusicDetailViewSpec: XCTestCase {
    var view: MusicDetailView?
    
    override func setUp() {
        guard let music = mockMusic() else {
            return
        }
        view = MusicDetailView()
        view?.setupView(music: music)
    }
    
    func testClassInitializers() {
        XCTAssertNotNil(self.view)
    }
    
    func testViewConstructors() {
        XCTAssertEqual(view?.subviews.count, 3)
    }
    
    private func mockMusic() -> Musics? {
        if let responseMock = JSONHandler().readJson(type: Musics.self, fileName: "Music") {
            return responseMock
        } else {
            return nil
        }
    }
}
