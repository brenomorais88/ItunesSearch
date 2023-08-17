//
//  LoadingViewSpec.swift
//  ItunesSearchTests
//
//  Created by Breno Morais on 17/08/23.
//

import Foundation
import XCTest
@testable import ItunesSearch

class LoadingViewSpec: XCTestCase {
    var view: LoadingView?
    
    override func setUp() {
        view = LoadingView()
    }
    
    func testClassInitializers() {
        XCTAssertNotNil(self.view)
    }
    
    func testViewConstructors() {
        XCTAssertEqual(view?.subviews.count, 2)
    }
}
