//
//  RoomsListViewController.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 13/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RoomsListViewController: View{

    //DI
    var navigator:Navigation?
    var roomsViewModel:RoomsViewModel?
    
    //Private Vars
    private let refreshControl: UIRefreshControl = {
        let refreshView = UIRefreshControl()
        refreshView.tintColor = .black
        refreshView.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshView
    }()
    
    private let tableView = UITableView()
    private let cellNameId = "Cell"
    private let disposableBag = DisposeBag()
    
    func resolveDI() {
        navigator = DIManager.resolveNavigation()
        roomsViewModel = DIManager.resolveRoomsViewModel()
    }
    
    func setUpViews() {
        setUpTableView()
        setErrorButton()
    }
    
    func bindData(){
        roomsViewModel?.state
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
            .map({state -> [RoomCellViewModel] in
                return state.data
            })
            .bind(to: tableView.rx.items(cellIdentifier: cellNameId, cellType: RoomTableViewCell.self)){
               (i, model, cell) in
                cell.roomCellViewModel = model
            }
           .disposed(by: disposableBag)
        
        tableView.rx.modelSelected(RoomCellViewModel.self)
            .subscribe(onNext: {[unowned self] (room) in
                self.navigator?.navigateToDetail(from: self, paramViewModel: room)
           }).disposed(by: disposableBag)
    
    }
    
    //MARK:- USER ACTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomsViewModel?.fetchData()
    }
    
    @objc func errorPressed(sender: UIButton!) {
        roomsViewModel?.fetchData()
    }
    
    @objc func refresh(sender:AnyObject) {
        roomsViewModel?.fetchData()
    }
    
    //MARK:- PRIVATE FUNCTIONS
    
    private func setUpTableView(){
       
        // Table View
        view.addSubview(tableView)
        
        tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: cellNameId)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        tableView.accessibilityLabel = "List of Rooms"
        
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
