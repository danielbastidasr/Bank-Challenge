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
    
    let tableView = UITableView()
    
    let disposableBag = DisposeBag()
    let cellNameId = "Cell"
    
    var peopleViewModel: PeopleViewModel?
    var navigator:Navigation?
    
    func resolveDI() {
        navigator = DIManager.resolveNavigation()
        peopleViewModel = DIManager.resolvePeopleViewModel()
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
                cell.personViewModel = model
            }
           .disposed(by: disposableBag)
               
        tableView.rx.modelSelected(String.self)
            .subscribe(onNext: {[unowned self] (person) in
                self.navigator?.navigateToDetail(from: self, paramViewModel: person)
           }).disposed(by: disposableBag)
    }
}
