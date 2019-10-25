//
//  MockURLOpener.swift
//  MarvelRxTests
//
//  Created by Mike Gopsill on 23/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import Foundation

@testable import MarvelRxFRP

final class MockURLOpener: URLOpener {
    var openCalledURL: URL?
    
    func open(_ url: URL) {
        openCalledURL = url
    }
}
