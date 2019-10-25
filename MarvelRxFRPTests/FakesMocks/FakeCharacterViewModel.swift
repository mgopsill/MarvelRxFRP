//
//  FakeCharacterViewModel.swift
//  MarvelRxTests
//
//  Created by Mike Gopsill on 23/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

@testable import MarvelRxFRP

final class FakeCharacterViewModel: CharacterViewModelProtocol {
    var input: CharacterViewModel.Input
    var output: CharacterViewModel.Output
    
    var fakeSelectCharacter = PublishSubject<MarvelCharacter?>()
    var fakeMarvelCharacters = PublishSubject<[MarvelCharacter]>()
    
    init() {
        input = CharacterViewModel.Input(selectCharacter: fakeSelectCharacter.asObserver())
        output = CharacterViewModel.Output(marvelCharacters: fakeMarvelCharacters.asDriver(onErrorJustReturn: []),
                                           didSelectCharacter: fakeSelectCharacter.asDriver(onErrorJustReturn: nil))
    }
}
