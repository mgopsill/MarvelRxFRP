//
//  CharacterDetailView.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 23/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import UIKit

class CharacterDetailView: UIView {
    let image = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let button = UIButton()
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        image.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(image)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(button)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        button.backgroundColor = .blue
        button.setTitle("Website", for: .normal)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 40.0),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 200.0),
            image.widthAnchor.constraint(equalToConstant: 200.0),
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20.0),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40.0),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40.0),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40.0),
            button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40.0),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200.0),
            button.heightAnchor.constraint(equalToConstant: 40.0)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
