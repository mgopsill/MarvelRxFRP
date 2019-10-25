//
//  CharacterViewController.swift
//  MarvelRx
//
//  Created by Mike Gopsill on 18/10/2019.
//  Copyright © 2019 mgopsill. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

class CharacterViewController: UIViewController {
    
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Characters"
        setupTableView()
        bindUI()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.reuseIdentifier)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    private func bindUI() {
        let (marvelCharacters, didSelectCharacter) = characterViewModel(selectCharacter: tableView.rx.modelSelected(MarvelCharacter.self).asObservable())

        disposeBag.insert(
            marvelCharacters
                .drive(tableView.rx.items(cellIdentifier: CharacterTableViewCell.reuseIdentifier, cellType: CharacterTableViewCell.self)) { (row , character, cell) in
                    cell.bind(using: character)
            },
            didSelectCharacter.drive(onNext: { [weak self] character in
                let vc = CharacterDetailViewController.configure(with: character)
                self?.navigationController?.pushViewController(vc, animated: true)
            })
        )
    }
}

