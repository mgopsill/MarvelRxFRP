//
//  FakeMarvelCharacter.swift
//  MarvelRxTests
//
//  Created by Mike Gopsill on 23/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import Foundation

@testable import MarvelRxFRP

extension MarvelCharacter {
    static func fake(urlString: String = "test") -> MarvelCharacter {
        return MarvelCharacter(name: "fakeName",
                               description: "fakeDescription",
                               thumbnail: Thumbnail(path: "fakePath", thumbnailExtension: .jpg),
                               urls: [ApiUrls(type: .detail, url: urlString)])
    }
}
