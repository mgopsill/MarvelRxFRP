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
    
    private let image = UIImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let button = UIButton()
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
        
        image.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(image)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(button)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        button.backgroundColor = .blue
        button.setTitle("Website", for: .normal)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 200.0),
            image.widthAnchor.constraint(equalToConstant: 200.0),
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20.0),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
            button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40.0),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200.0),
            button.heightAnchor.constraint(equalToConstant: 40.0)
            ])
    }
    
    private func bindUI() {
        viewModel.output.characterImage.drive(image.rx.image).disposed(by: disposeBag)
        viewModel.output.characterName.drive(nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.characterDescription.drive(descriptionLabel.rx.text).disposed(by: disposeBag)
        
        button.rx.tap.bind(to: viewModel.input.buttonTap).disposed(by: disposeBag)
    }
}
