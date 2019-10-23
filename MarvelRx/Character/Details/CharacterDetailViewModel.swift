//
//  CharacterDetailViewModel.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 22/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxSwift
import RxCocoa

protocol CharacterDetailViewModelProtocol {
    var input: CharacterDetailViewModel.Input { get }
    var output: CharacterDetailViewModel.Output { get }
}

final class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    let input: Input
    let output: Output
    
    struct Input {
        let buttonTap: AnyObserver<Void>
    }
    
    struct Output {
        let characterImage: Driver<UIImage?>
        let characterName: Driver<String>
        let characterDescription: Driver<String>
        let buttonTapped: Driver<URL?>
    }
    
    private let buttonTapSubject = PublishSubject<Void>()

    init(character: MarvelCharacter, imageProvider: ImageProviderProtocol = ImageProvider()) {
        let characterImage = imageProvider.image(for: character.imageURL).asDriver(onErrorJustReturn: nil)
        let buttonTapped = buttonTapSubject.map { character.descriptionURL }.asDriver(onErrorJustReturn: nil)
        output = Output(characterImage: characterImage,
                        characterName: Driver.just(character.name),
                        characterDescription: Driver.just(character.description),
                        buttonTapped: buttonTapped)
        input = Input(buttonTap: buttonTapSubject.asObserver())
    }
}
