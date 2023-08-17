//
//  ErrorViewSpec.swift
//  ItunesSearchTests
//
//  Created by Breno Morais on 17/08/23.
//

import Foundation
import XCTest
@testable import ItunesSearch

class ErrorViewSpec: XCTestCase {
    var view: ErrorView?
    
    override func setUp() {
        view = ErrorView(error: "testing error")
    }
    
    func testClassInitializers() {
        XCTAssertNotNil(self.view)
    }
    
    func testViewConstructors() {
        XCTAssertEqual(view?.subviews.count, 2)
        XCTAssertEqual(view?.error, "testing error")
    }
    
}
