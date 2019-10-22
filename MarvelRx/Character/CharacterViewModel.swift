//
//  CharacterViewModel.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 22/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxSwift
import RxCocoa

final class CharacterViewModel {
    let input: Input
    let output: Output
    
    struct Input {
        let selectCharacter: AnyObserver<MarvelCharacter?>
    }
    
    struct Output {
        let marvelCharacters: Driver<[MarvelCharacter]>
        let didSelectCharacter: Driver<MarvelCharacter?>
    }
    let characterStrings = BehaviorSubject<[MarvelCharacter]>(value: [])
    
    private let selectCharacterSubject = PublishSubject<MarvelCharacter?>()
    private let disposeBag = DisposeBag()

    init(characterService: CharacterServiceProtocol = CharacterService()) {
        
        characterService.fetchCharacters()
            .map { model -> [MarvelCharacter] in
                guard let model = model else { return [] }
                return model.data.characters
            }
            .bind(to: characterStrings)
            .disposed(by: disposeBag)

        output = Output(marvelCharacters: characterStrings.asDriver(onErrorJustReturn: []), didSelectCharacter: selectCharacterSubject.asDriver(onErrorJustReturn: nil))
        input = Input(selectCharacter: selectCharacterSubject.asObserver())
    }
}
