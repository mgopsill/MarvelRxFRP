//
//  AppDelegate.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 18/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let appDidFinishLaunching = appDelegateViewModel(applicationDidFinishLaunching: .just(window))
        
        appDidFinishLaunching.drive(onNext: { window in
            guard let window = window else { return }
            let navigationController = UINavigationController(rootViewController: CharacterViewController())
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }).disposed(by: disposeBag)
        
        return true
    }
}

fileprivate func appDelegateViewModel(applicationDidFinishLaunching: Observable<UIWindow?>) -> Driver<UIWindow?> {
    return applicationDidFinishLaunching.asDriver(onErrorJustReturn: nil)
}

