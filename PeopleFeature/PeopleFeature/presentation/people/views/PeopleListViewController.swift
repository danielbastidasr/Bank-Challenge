//
//  PeopleListViewController.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 13/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PeopleListViewController: View {
    
    // DI
    var peopleViewModel: PeopleViewModel?
    var navigator:Navigation?
    
    private let tableView = UITableView()
    private let disposableBag = DisposeBag()
    private let cellNameId = "Cell"
    
    func resolveDI() {
        navigator = DIManager.resolveNavigation()
        peopleViewModel = DIManager.resolvePeopleViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        peopleViewModel?.fetchData()
    }
    
    func setUpViews() {
        view.addSubview(tableView)
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: cellNameId)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        tableView.accessibilityLabel = "List of People"
    }
    
    func bindData() {
        peopleViewModel?.peopleList.observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: cellNameId, cellType: PersonTableViewCell.self)){
               (i, model, cell) in
                cell.personCellViewModel = model
            }
           .disposed(by: disposableBag)
               
        tableView.rx.modelSelected(PersonCellViewModel.self)
            .subscribe(onNext: {[unowned self] (person) in
                self.navigator?.navigateToDetail(from: self, personCellViewModel: person)
           }).disposed(by: disposableBag)
    }
}
