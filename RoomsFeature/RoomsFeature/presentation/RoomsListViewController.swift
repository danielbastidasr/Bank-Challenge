//
//  RoomsListViewController.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 13/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import UIKit

class RoomsListViewController: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    //MARK:- UI Setup

    private func setupTableView() {
      
        view.addSubview(tableView)
        tableView.isAccessibilityElement = true
        tableView.accessibilityLabel = "List of rooms"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    //MARK:- Navigation
    
    @objc func buttonAction() {
        let vc = RoomDetailViewController()
        if let navController = self.navigationController {
            vc.modalPresentationStyle = .fullScreen
            navController.pushViewController(vc, animated: true)
        }
        else{
            self.present(vc, animated: true, completion: nil)
        }
    }
}
