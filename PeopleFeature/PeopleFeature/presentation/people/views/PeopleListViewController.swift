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
    
    //Views
    private let refreshControl: UIRefreshControl = {
        let refreshView = UIRefreshControl()
        refreshView.tintColor = .black
        refreshView.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshView
    }()
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
        peopleViewModel?.state
            .observeOn(MainScheduler.instance)
            .do(onNext: { [unowned self](state) in
                if (state.isError){
                    self.showError()
                }
                else if(state.isLoading){
                    self.refreshControl.beginRefreshing()
                }
                else{
                    self.showData()
                }
            })
            .subscribeOn(CurrentThreadScheduler.instance)
            .map({ (state) -> [PersonCellViewModel] in
                return state.data
            })
            .observeOn(MainScheduler.instance)
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
    
    //MARK:- USER ACTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleViewModel?.fetchData()
    }
    
    @objc func errorPressed(sender: UIButton!) {
        peopleViewModel?.fetchData()
    }
    
    @objc func refresh(sender:AnyObject) {
        peopleViewModel?.fetchData()
    }
    
    //MARK:- PRIVATE FUNCTIONS
    
    private func setUpTableView(){
        
        // Table View
        view.addSubview(tableView)
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: cellNameId)
        tableView.estimatedRowHeight = 120
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        tableView.accessibilityLabel = "List of People"
        
        // Refresh
        tableView.refreshControl = refreshControl
    }
    
    private func showError(){
        errorView.isHidden = false
        refreshControl.endRefreshing()
    }
    
    private func showData(){
        errorView.isHidden = true
        refreshControl.endRefreshing()
    }
    
    private func setErrorButton(){
        self.errorButton.addTarget(self, action:#selector(errorPressed), for: .touchUpInside)
    }
}
