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
    
    private let viewModel: CharacterViewModel
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    init(viewModel: CharacterViewModel = CharacterViewModel()) {
        self.viewModel = viewModel
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
        viewModel.output.marvelCharacters
            .drive(tableView.rx.items(cellIdentifier: CharacterTableViewCell.reuseIdentifier, cellType: CharacterTableViewCell.self)) { (row , character, cell) in
                let cellViewModel = CharacterCellViewModel(character: character)
                cell.bind(to: cellViewModel)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(MarvelCharacter.self)
            .bind(to: viewModel.input.selectCharacter)
            .disposed(by: disposeBag)
    }
}

