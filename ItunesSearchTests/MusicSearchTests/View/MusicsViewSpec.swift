//
//  MusicsViewSpec.swift
//  ItunesSearchTests
//
//  Created by Breno Morais on 17/08/23.
//

import Foundation
import XCTest
@testable import ItunesSearch

class MusicsViewSpec: XCTestCase {
    var view: MusicsView?
    
    override func setUp() {
        guard let music = mockMusic() else {
            return
        }
        view = MusicsView(musics: [music])
    }
    
    func testClassInitializers() {
        XCTAssertNotNil(self.view)
    }
    
    func testViewConstructors() {
        XCTAssertEqual(view?.subviews.count, 1)
        XCTAssertEqual(view?.musics.count, 1)
    }
    
    private func mockMusic() -> Musics? {
        if let responseMock = JSONHandler().readJson(type: Musics.self, fileName: "Music") {
            return responseMock
        } else {
            return nil
        }
    }
}
