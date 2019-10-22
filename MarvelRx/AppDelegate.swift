//
//  AppDelegate.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 18/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootCoordinator: RootCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        rootCoordinator = RootCoordinator(window: window)
        rootCoordinator?.start()
        return true
    }
}

