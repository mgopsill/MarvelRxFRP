//
//  CharacterDetailViewController.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 22/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxSwift
import UIKit

class CharacterDetailViewController: UIViewController {
    
    static func configure(with character: MarvelCharacter) -> CharacterDetailViewController {
        let characterDetailViewController = CharacterDetailViewController()
        characterDetailViewController.bindUI(with: character)
        return characterDetailViewController
    }
    
    private let characterDetailView = CharacterDetailView()
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(characterDetailView)
        
        NSLayoutConstraint.activate([
            characterDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterDetailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterDetailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            characterDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    private func bindUI(with character: MarvelCharacter) {
        let (characterImage, characterName, characterDescription, buttonTapped) =
            characterDetailViewModel(
                character: character,
                buttonTapped: characterDetailView.button.rx.controlEvent(.touchUpInside).asObservable()
        )
        
        disposeBag.insert(
            characterImage.drive(characterDetailView.image.rx.image),
            characterName.drive(characterDetailView.nameLabel.rx.text),
            characterDescription.drive(characterDetailView.descriptionLabel.rx.text),
            buttonTapped.drive(onNext: { url in
                guard let url = url else { return }
                UIApplication.shared.open(url)
            })
        )
    }
}


