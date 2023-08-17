////
////  HearthstoneCardsTests.swift
////  HearthstoneCardsTests
////
////  Created by Breno Morais on 04/08/23.
////
//
//import XCTest
//@testable import HearthstoneCards
//
//class HearthstoneCardsServiceMock: HearthstoneCardsServiceProtocol {
//    var jsonMock = ""
//
//    func loadCards(callback: @escaping (Bool, [CardsResponse]?) -> ()) {
//        if let responseMock = JSONHandler().readJson(type: [CardsResponse].self, fileName: self.jsonMock) {
//            if responseMock.count > 0 {
//                callback(true, responseMock)
//            } else {
//                callback(false, nil)
//            }
//
//        } else {
//            callback(false, nil)
//        }
//    }
//}
//
//class HearthstoneCardsTests: XCTestCase {
//    let service = HearthstoneCardsServiceMock()
//    let sceneFactory = DefaultSceneFactory()
//    let vc = HearthstoneCardsViewController()
//    let interactor = HearthstoneCardsInteractor()
//    let presenter = HearthstoneCardsPresenter()
//    var worker: HearthstoneCardsWorker?
//    var router: HearthstoneCardsRouter?
//
//    override func setUp() {
//        worker = HearthstoneCardsWorker(service: service)
//        router = HearthstoneCardsRouter(sceneFactory: sceneFactory)
//
//        router?.source = vc
//        presenter.viewController = vc
//        interactor.presenter = presenter
//        interactor.worker = worker
//        vc.interactor = interactor
//        vc.router = router
//    }
//
//    func testClassInitializers() {
//        XCTAssertNotNil(self.worker)
//        XCTAssertNotNil(self.router)
//    }
//
//    func testErrorCase() {
//        self.service.jsonMock = "Cards_erro"
//        let errorView = self.vc.view as? HearthstoneCardsErrorView
//        XCTAssertNotNil(errorView)
//    }
//
//    func testNormalCase() {
//        self.service.jsonMock = "Cards"
//        let view = self.vc.view as? HearthstoneCardsView
//        self.vc.tryAgain()
//        XCTAssertNotNil(view)
//        XCTAssertEqual(view?.cards.count, 27)
//    }
//}
