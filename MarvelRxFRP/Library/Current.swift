//
//  Current.swift
//  MarvelRxFRP
//
//  Created by Mike Gopsill on 25/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import Foundation

struct World {
    var api = CharacterAPI()
    var images = Images()
}

struct CharacterAPI {
    var fetchCharacters = CharacterAPIClient.shared.fetchCharacters
}

struct Images {
    var image = ImageProviderV2.shared.image(for:)
}

#if DEBUG
var Current = World()
#else
let Current = World()
#endif
