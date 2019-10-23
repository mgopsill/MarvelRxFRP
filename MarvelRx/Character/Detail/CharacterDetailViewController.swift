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
    
    let viewModel: CharacterDetailViewModelProtocol
    
    private let characterDetailView = CharacterDetailView()
    private let disposeBag = DisposeBag()
    
    init(viewModel: CharacterDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindUI()
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
    
    private func bindUI() {
        viewModel.output.characterImage.drive(characterDetailView.image.rx.image).disposed(by: disposeBag)
        viewModel.output.characterName.drive(characterDetailView.nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.characterDescription.drive(characterDetailView.descriptionLabel.rx.text).disposed(by: disposeBag)
        
        characterDetailView.button.rx.tap.bind(to: viewModel.input.buttonTap).disposed(by: disposeBag)
    }
}
