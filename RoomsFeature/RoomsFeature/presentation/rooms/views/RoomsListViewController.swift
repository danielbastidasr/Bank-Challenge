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
    private let disposableBag = DisposeBag()
    private let cellNameId = "Cell"
    
    func resolveDI() {
        navigator = DIManager.resolveNavigation()
        roomsViewModel = DIManager.resolveRoomsViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        roomsViewModel?.fetchData()
    }
    
    func setUpViews() {
        view.addSubview(tableView)
        tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: cellNameId)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        tableView.accessibilityLabel = "List of Rooms"
    }
    
    func bindData(){
        roomsViewModel?.listRooms.observeOn(MainScheduler.instance)
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
}
