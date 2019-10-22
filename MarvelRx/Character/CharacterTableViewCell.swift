//
//  File.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 22/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    let title: UILabel = UILabel()
    let characterImageView: UIImageView = UIImageView()
    private var disposeBag = DisposeBag()
    
    static let reuseIdentifier = "Characters"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        title.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(title)
        contentView.addSubview(characterImageView)
        characterImageView.contentMode = .scaleAspectFit
        
        let constraints:[NSLayoutConstraint] = [
            contentView.heightAnchor.constraint(equalToConstant: 100.0),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40.0),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 20.0),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to viewModel: CharacterCellViewModel) {
        viewModel.output.name.drive(title.rx.text).disposed(by: disposeBag)
        viewModel.output.image.drive(characterImageView.rx.image).disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
        characterImageView.image = nil
        title.text = ""
    }
}
