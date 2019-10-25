//
//  CharacterDetailViewModel.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 22/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxSwift
import RxCocoa

func characterDetailViewModel(
    character: MarvelCharacter,
    buttonTapped: Observable<Void>
    ) -> (
    characterImage: Driver<UIImage?>,
    characterName: Driver<String>,
    characterDescription: Driver<String>,
    buttonTapped: Driver<URL?>
    ) {
        func descriptionURL(void: (())) -> URL? {
            return character.descriptionURL
        }
        
        let characterImage = Current.images.image(character.imageURL).asDriver(onErrorJustReturn: nil)
        let characterName = Driver.just(character.name)
        let characterDescription = Driver.just(character.description)
        let buttonTapped = buttonTapped.map(descriptionURL).asDriver(onErrorJustReturn: nil)

        return (
            characterImage: characterImage,
            characterName: characterName,
            characterDescription: characterDescription,
            buttonTapped: buttonTapped
        )
}

