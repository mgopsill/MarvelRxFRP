//
//  RootCoordinatorTests.swift
//  MarvelRxTests
//
//  Created by Mike Gopsill on 22/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxSwift
import XCTest

@testable import MarvelRx

class RootCoordinatorTests: XCTestCase {
    
    var subject: RootCoordinator!
    var mockWindow: UIWindow!
    var mockNavigationController: MockNavigationController!
    var fakeCharacterViewModel: FakeCharacterViewModel!
    var fakeCharacterViewControllerFactory: FakeCharacterViewControllerFactory!
    var mockURLOpener: MockURLOpener!

    override func setUp() {
        super.setUp()
        
        mockWindow = UIWindow(frame: CGRect.zero)
        mockNavigationController = MockNavigationController()
        fakeCharacterViewModel = FakeCharacterViewModel()
        fakeCharacterViewControllerFactory = FakeCharacterViewControllerFactory()
        mockURLOpener = MockURLOpener()
        subject = RootCoordinator(window: mockWindow,
                                  navigationController: mockNavigationController,
                                  characterViewModel: fakeCharacterViewModel,
                                  characterViewControllerFactory: fakeCharacterViewControllerFactory,
                                  urlOpener: mockURLOpener)
    }

    override func tearDown() {
        subject = nil
        super.tearDown()
    }

    func test_givenStartCalled_viewControllerIsCharacterViewController() {
        subject.start()
        XCTAssertTrue(mockNavigationController.viewControllers.first is CharacterViewController)
    }
    
    func test_givenStartCalled_characterViewModelEmits_pushesDetailController() {
        subject.start()
        fakeCharacterViewModel.fakeSelectCharacter.onNext(MarvelCharacter.fake())
        XCTAssertTrue(mockNavigationController.pushedViewController is CharacterDetailViewController)
    }
    
    func test_givenStartCalled_characterViewModelEmitsNil_doesNotPushDetailController() {
        subject.start()
        fakeCharacterViewModel.fakeSelectCharacter.onNext(nil)
        XCTAssertFalse(mockNavigationController.pushedViewController is CharacterDetailViewController)
    }
    
    func test_givenStartCalled_detailViewControllerPushed_detailsViewModelEmits_opensSafari() {
        subject.start()
        subject.pushDetailViewController(for: MarvelCharacter.fake())
        fakeCharacterViewControllerFactory.fakeCharacterDetailViewModel?.fakeButtonTap.onNext(())
        XCTAssertEqual(mockURLOpener.openCalledURL, URL(string: "test"))
    }
    
    func test_givenStartCalled_detailViewControllerPushed_detailsViewModelEmitsInvalidURL_opensSafari() {
        subject.start()
        subject.pushDetailViewController(for: MarvelCharacter.fake(urlString: ""))
        fakeCharacterViewControllerFactory.fakeCharacterDetailViewModel?.fakeButtonTap.onNext(())
        XCTAssertNil(mockURLOpener.openCalledURL)
    }
}
