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
    
    init(window: UIWindow,
         navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CharacterViewModel()
        let viewController = CharacterViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        viewModel.output.didSelectCharacter.drive(onNext: { [weak self] character in
            self?.pushDetailViewController(for: character)
        }).disposed(by: disposeBag)
    }
    
    private func pushDetailViewController(for character: MarvelCharacter?) {
        let viewModel = CharacterDetailViewModel(character: character!)
        let viewController = CharacterDetailViewController(viewModel: viewModel)
        
        viewModel.output.buttonTapped.drive(onNext: { url in
            guard let url = url else { return }
            UIApplication.shared.open(url)
        }).disposed(by: disposeBag)
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
