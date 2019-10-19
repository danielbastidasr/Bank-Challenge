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
    private var peopleViewModel: PeopleViewModel?
    private var navigator:Navigation?
    
    private let tableView = UITableView()
    private let disposableBag = DisposeBag()
    private let cellNameId = "Cell"
    
    func resolveDI() {
        navigator = DIManager.resolveNavigation()
        peopleViewModel = DIManager.resolvePeopleViewModel()
    }
    
    func setUpViews() {
        setUpTableView()
        setErrorButton()
    }
    
    func bindData() {
        peopleViewModel?.peopleList
            .observeOn(MainScheduler.instance)
            .map({[unowned self] people -> [PersonCellViewModel] in
                if(people.count > 0){
                    self.errorView.isHidden = true
                }
                return people
            })
            .bind(to: tableView.rx.items(cellIdentifier: cellNameId, cellType: PersonTableViewCell.self)){
               (i, model, cell) in
                cell.personCellViewModel = model
            }
           .disposed(by: disposableBag)
               
        peopleViewModel?.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[unowned self] _ in
                self.errorView.isHidden = false
            }).disposed(by: disposableBag)
        
        tableView.rx.modelSelected(PersonCellViewModel.self)
            .subscribe(onNext: {[unowned self] (person) in
                self.navigator?.navigateToDetail(from: self, personCellViewModel: person)
           }).disposed(by: disposableBag)
    }
    
    //MARK:- USER ACTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleViewModel?.fetchData()
    }
    
    @objc func errorPressed(sender: UIButton!) {
        peopleViewModel?.fetchData()
    }
    
    //MARK:- PRIVATE FUNCTIONS
    
    private func setErrorButton(){
        self.errorButton.addTarget(self, action:#selector(errorPressed), for: .touchUpInside)
    }
    
    private func setUpTableView(){
        view.addSubview(tableView)
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: cellNameId)
        tableView.estimatedRowHeight = 120
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        tableView.accessibilityLabel = "List of People"
    }
}
