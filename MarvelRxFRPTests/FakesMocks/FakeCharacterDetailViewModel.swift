//
//  FakeCharacterDetailViewModel.swift
//  MarvelRxTests
//
//  Created by Mike Gopsill on 23/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

@testable import MarvelRxFRP

//final class FakeCharacterDetailViewModel: CharacterDetailViewModelProtocol {
//    var input: CharacterDetailViewModel.Input
//    var output: CharacterDetailViewModel.Output
//    
//    var fakeButtonTap = PublishSubject<Void>()
//    var fakeCharacterURL: URL?
//    
//    init(character: MarvelCharacter) {
//        let buttonTapped = fakeButtonTap.map { character.descriptionURL }.asDriver(onErrorJustReturn: nil)
//        output = CharacterDetailViewModel.Output(characterImage: Observable.just(nil).asDriver(onErrorJustReturn: nil),
//                                                 characterName: Observable.just("testName").asDriver(onErrorJustReturn: ""),
//                                                 characterDescription: Observable.just("testName").asDriver(onErrorJustReturn: ""),
//                                                 buttonTapped: buttonTapped)
//        input = CharacterDetailViewModel.Input(buttonTap: fakeButtonTap.asObserver())
//    }
//}
