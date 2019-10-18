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

class RoomsListViewController: View {
    
    //DI
    var navigator:Navigation?
    var roomsViewModel:RoomsViewModel?
    
    //Private Vars
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
        roomsViewModel?.listRooms
            .observeOn(MainScheduler.instance)
            .map({[unowned self] cells -> [RoomCellViewModel] in
                if(cells.count > 0 ){
                    self.errorView.isHidden = true
                }
                return cells
            })
            .bind(to: tableView.rx.items(cellIdentifier: cellNameId, cellType: RoomTableViewCell.self)){
               (i, model, cell) in
                cell.roomCellViewModel = model
            }
           .disposed(by: disposableBag)
        
        roomsViewModel?.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[unowned self] _ in
                self.errorView.isHidden = false
            }).disposed(by: disposableBag)
               
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
    
    //MARK:- PRIVATE FUNCTIONS
    
    private func setUpTableView(){
        view.addSubview(tableView)
        tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: cellNameId)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        tableView.accessibilityLabel = "List of Rooms"
    }
    
    private func setErrorButton(){
        self.errorButton.addTarget(self, action:#selector(errorPressed), for: .touchUpInside)
    }
    
}
