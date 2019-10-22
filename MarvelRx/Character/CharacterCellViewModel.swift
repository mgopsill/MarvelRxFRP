//
//  CharacterCellViewModel.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 22/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

final class CharacterCellViewModel {
    let output: Output
    
    struct Output {
        let name: Driver<String>
        let image: Driver<UIImage?>
    }
    
    init(character: MarvelCharacter, imageProvider: ImageProviderProtocol = ImageProvider()) {
        output = Output(name: Driver.of(character.name), image: imageProvider.image(for: character.imageURL).asDriver(onErrorJustReturn: nil))
    }
}
