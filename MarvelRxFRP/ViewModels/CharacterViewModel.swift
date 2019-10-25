//
//  CharacterViewModel.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 22/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxSwift
import RxCocoa

func characterViewModel(
    selectCharacter: Observable<MarvelCharacter>
    ) -> (
    marvelCharacters: Driver<[MarvelCharacter]>,
    didSelectCharacter: Driver<MarvelCharacter>
    ) {
        func unwrapCharacters( _ model: CharacterResponseModel?) -> [MarvelCharacter] {
            guard let model = model else { return [] }
            return model.data.characters
        }
        
        let marvelCharacters = Current.api.fetchCharacters().map(unwrapCharacters).asDriver(onErrorJustReturn: [])
        let didSelectCharacter = selectCharacter.asDriver(onErrorJustReturn: MarvelCharacter(name: " ", description: " ", thumbnail: Thumbnail(path: " ", thumbnailExtension: .jpg), urls: [])) // How to handle this as I know it won't error
        
        return (
            marvelCharacters: marvelCharacters,
            didSelectCharacter: didSelectCharacter
        )
}
