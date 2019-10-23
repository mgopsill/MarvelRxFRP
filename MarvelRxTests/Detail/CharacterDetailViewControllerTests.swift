//
//  CharacterDetailViewControllerTests.swift
//  MarvelRxTests
//
//  Created by Mike Gopsill on 23/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxBlocking
import RxCocoa
import RxSwift
import RxTest
import XCTest

@testable import MarvelRx

final class CharacterDetailViewModelTests: XCTestCase {
    
    var subject: CharacterDetailViewModel!
    var fakeImageProvider: FakeImageProvider!
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        testScheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        
        fakeImageProvider = FakeImageProvider()
        subject = CharacterDetailViewModel(character: MarvelCharacter.fake(),
                                           imageProvider: fakeImageProvider)
    }
    
    override func tearDown() {
        subject = nil
        super.tearDown()
    }

    func test_givenImageExists_outputsImage() {
        let testImage = UIImage()
        fakeImageProvider.image.onNext(testImage)
        XCTAssertEqual(try subject.output.characterImage.toBlocking().first(), testImage)
    }
    
    func test_givenImageDoesNotExist_outputsNil() {
        fakeImageProvider.image.onNext(nil)
        XCTAssertEqual(try subject.output.characterImage.toBlocking().first() ?? nil, nil)
    }
    
    func test_characterName_outputsName() {
        XCTAssertEqual(try subject.output.characterName.toBlocking().first(), "fakeName")
    }
    
    func test_characterDescription_outputsDescription() {
        fakeImageProvider.image.onNext(nil)
        XCTAssertEqual(try subject.output.characterDescription.toBlocking().first(), "fakeDescription")
    }
    
    func test_buttonTapped_outputsURL() {
        // add an observer to the testScheduler, that will observe elements of type you expect
        let emittedURL = testScheduler.createObserver(URL?.self)
        
        // drive the observer created from your output
        subject.output.buttonTapped.drive(emittedURL).disposed(by: disposeBag)
        
        // create a fake tap that emits void at time 10 (10 is an arbitrary time that will be checked later)
        testScheduler.createColdObservable([.next(10,())])
            .bind(to: subject.input.buttonTap)
            .disposed(by: disposeBag)
        
        // start the scheduler
        testScheduler.start()
        
        // check the emitted events using the arbitrary time you emitted first
        XCTAssertEqual(emittedURL.events, [.next(10,(URL(string: "test")))])
    }
}

final class FakeImageProvider: ImageProviderProtocol {
    var image = BehaviorSubject<UIImage?>(value: nil)
    func image(for url: URL?) -> Observable<UIImage?> {
        return image.asObservable()
    }
}
