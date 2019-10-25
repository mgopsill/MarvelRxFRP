//
//  ImageProvider.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 22/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxSwift

struct ImageCache {
    static let cache = NSCache<NSString, UIImage>()
}

struct ImageProvider {
    private init() { }
    public static let shared = ImageProvider()
    
    private func getNetworkImage(from url: URL?) -> Observable<UIImage?> {
        guard let url = url else { return Observable.just(nil) }
        return URLSession.shared.data(from: url).map { data -> UIImage? in
            guard let image = UIImage(data: data) else { return nil }
            ImageCache.cache.setObject(image, forKey: url.absoluteString as NSString)
            return image
            }.asObservable()
    }
    
    func image(for url: URL?) -> Observable<UIImage?> {
        guard let url = url else { return Observable.just(nil) }
        if let image = ImageCache.cache.object(forKey: url.absoluteString as NSString) {
            return Observable.just(image)
        } else {
            return getNetworkImage(from: url)
        }
    }
}
