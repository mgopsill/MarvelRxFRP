//
//  CharacterViewControllerFactory.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 23/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import UIKit

protocol CharacterViewControllerProvider {
    func getCharacterDetailViewController(for character: MarvelCharacter?) -> CharacterDetailViewController?
}

final class CharacterViewControllerFactory: CharacterViewControllerProvider {
    func getCharacterDetailViewController(for character: MarvelCharacter?) -> CharacterDetailViewController? {
        guard let character = character else { return nil }
        let viewModel = CharacterDetailViewModel(character: character)
        return CharacterDetailViewController(viewModel: viewModel)
    }
}
