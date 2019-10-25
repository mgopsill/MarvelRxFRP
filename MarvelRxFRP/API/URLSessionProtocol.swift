//
//  URLSessionProtocol.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 22/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxSwift
import RxCocoa

protocol URLSessionProtocol {
    func data(from url: URL) -> Observable<Data>
}

extension URLSession: URLSessionProtocol {
    func data(from url: URL) -> Observable<Data> {
        let request = URLRequest(url: url)
        return self.rx.data(request: request)
    }
}
