//
//  main.swift
//  MarvelRxFRP
//
//  Created by Mike Gopsill on 25/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import UIKit

let appDelegateClass: AnyClass = NSClassFromString("MarvelRxFRPTests.TestingAppDelegate") ?? AppDelegate.self
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass))
