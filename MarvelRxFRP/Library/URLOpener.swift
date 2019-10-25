//
//  URLOpener.swift
//  MarvelRxFRP
//
//  Created by Mike Gopsill on 25/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import UIKit

protocol URLOpener {
    func open(_ url: URL)
}

extension UIApplication: URLOpener {
    func open(_ url: URL) {
        self.open(url, options: [:], completionHandler: nil)
    }
}
