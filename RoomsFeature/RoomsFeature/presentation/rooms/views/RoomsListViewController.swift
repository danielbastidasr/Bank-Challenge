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
    
    let tableView = UITableView()
    let roomsViewModel = Observable.just(["Hello","World","Testing Here!"])
    let disposableBag = DisposeBag()
    let cellNameId = "Cell"
    
    func setUpViews() {
        view.addSubview(tableView)
        tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: cellNameId)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        tableView.accessibilityLabel = "List of Rooms"
    }
    
    func bindData(){
        roomsViewModel.observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: cellNameId, cellType: RoomTableViewCell.self)){
               (i, model, cell) in
               cell.room = model
            }
           .disposed(by: disposableBag)
               
        tableView.rx.modelSelected(String.self)
            .subscribe(onNext: {[unowned self] (room) in
               self.navigateToDetail(room: room)
           }).disposed(by: disposableBag)
    }
    
    //MARK:- Navigation
    
    private func navigateToDetail(room:String) {
        let vc = RoomDetailViewController()
        vc.roomViewModel = room
        if let navController = self.navigationController {
            vc.modalPresentationStyle = .fullScreen
            navController.pushViewController(vc, animated: true)
        }
        else{
            self.present(vc, animated: true, completion: nil)
        }
    }
}
