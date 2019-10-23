//
//  RootCoordinator.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 22/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxSwift
import UIKit

protocol Coordinator {
    func start()
}

final class RootCoordinator: Coordinator {
    
    private let disposeBag = DisposeBag()
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let characterViewModel: CharacterViewModelProtocol
    private let characterViewControllerFactory: CharacterViewControllerProvider
    private let urlOpener: URLOpener
    
    init(window: UIWindow,
         navigationController: UINavigationController,
         characterViewModel: CharacterViewModelProtocol,
         characterViewControllerFactory: CharacterViewControllerProvider,
         urlOpener: URLOpener) {
        self.window = window
        self.navigationController = navigationController
        self.characterViewModel = characterViewModel
        self.characterViewControllerFactory = characterViewControllerFactory
        self.urlOpener = urlOpener
    }
    
    convenience init(window: UIWindow) {
        self.init(window: window,
                  navigationController: UINavigationController(),
                  characterViewModel: CharacterViewModel(),
                  characterViewControllerFactory: CharacterViewControllerFactory(),
                  urlOpener: UIApplication.shared)
    }
    
    func start() {
        let viewController = CharacterViewController(viewModel: characterViewModel)
        navigationController.setViewControllers([viewController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        characterViewModel.output.didSelectCharacter.drive(onNext: { [unowned self] character in
            self.pushDetailViewController(for: character)
        }).disposed(by: disposeBag)
    }
    
    func pushDetailViewController(for character: MarvelCharacter?) {
        guard let vc = characterViewControllerFactory.getCharacterDetailViewController(for: character) else { return }
        
        vc.viewModel.output.buttonTapped.drive(onNext: { [unowned self]  url in
            guard let url = url else { return }
            self.urlOpener.open(url)
        }).disposed(by: disposeBag)
        
        self.navigationController.pushViewController(vc, animated: true)
    }
}

protocol URLOpener {
    func open(_ url: URL)
}

extension UIApplication: URLOpener {
    func open(_ url: URL) {
        self.open(url, options: [:], completionHandler: nil)
    }
}
