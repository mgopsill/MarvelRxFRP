//
//  CharacterDetailViewModelTests.swift
//  MarvelRxFRPTests
//
//  Created by Mike Gopsill on 25/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxBlocking
import RxSwift
import RxTest
import XCTest

@testable import MarvelRxFRP

class CharacterDetailViewModelTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        super.tearDown()
    }
    
    func test_characterDetailViewModel() throws {
        let stringObserver = scheduler.createObserver(String.self)
        let imageObserver = scheduler.createObserver(UIImage?.self)
        let buttonTappedObserver = scheduler.createObserver(URL?.self)
        
        let fakeImage = UIImage()
        func fakeImage(_ url: URL?) -> Observable<UIImage?> { return Observable.just(fakeImage) }
        Current.images.image = fakeImage(_:)
        
        let fakeCharacter = MarvelCharacter.fake()
        let fakeButtonTap = BehaviorSubject<Void>(value: ())
        
        let (image, name, description, buttonTapped) =
            characterDetailViewModel(character: fakeCharacter,
                                     buttonTapped: fakeButtonTap.asObservable())
        
        
        // Image
        XCTAssertEqual(try image.toBlocking().first(), fakeImage)
        
        // Name
        XCTAssertEqual(try name.toBlocking().first(), "fakeName")
        
        // Description
        XCTAssertEqual(try description.toBlocking().first(), "fakeDescription")
        
        // Button Tapped
        XCTAssertEqual(try buttonTapped.toBlocking().first(), URL(string: "test"))
    }
}
