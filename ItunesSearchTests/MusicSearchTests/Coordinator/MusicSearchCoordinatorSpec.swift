//
//  MusicSearchCoordinatorSpec.swift
//  ItunesSearchTests
//
//  Created by Breno Morais on 17/08/23.
//

import Foundation
import XCTest
@testable import ItunesSearch

class MusicSearchCoordinatorSpec: XCTestCase {
    let nav = UINavigationController()
    var coordinator: MusicSearchCoordinator?
    
    override func setUp() {
        coordinator = MusicSearchCoordinator(navigationController: nav)
    }
    
    func testClassInitializers() {
        XCTAssertNotNil(self.coordinator)
    }
    
    func testViewControllerInitializer() {
        XCTAssertNotNil(self.coordinator?.viewController)
    }
    
    func testScreenPush() {
        coordinator?.start()
        let topViewController = coordinator?.navigationController.topViewController
        XCTAssertNotNil(topViewController)
        XCTAssertTrue(topViewController is MusicSearchViewController)
    }
    
    func testDetailPush() {
        guard let music = mockMusic() else {
            XCTFail("Impossible to decode Music object")
            return
        }
        coordinator?.showDetail(music: music)
        let topViewController = coordinator?.navigationController.topViewController
        XCTAssertNotNil(topViewController)
        XCTAssertTrue(topViewController is MusicDetailViewController)
    }
    
    //MARK: Utils
    private func mockMusic() -> Musics? {
        if let responseMock = JSONHandler().readJson(type: Musics.self, fileName: "Music") {
            return responseMock
        } else {
            return nil
        }
    }
}
