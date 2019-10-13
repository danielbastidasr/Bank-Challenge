//
//  PeopleListViewController.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 13/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import UIKit

class PeopleListViewController: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    //MARK:- UI Setup

    private func setupTableView() {
      
        view.addSubview(tableView)
        tableView.isAccessibilityElement = true
        tableView.accessibilityLabel = "List of People"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    //MARK:- Navigation
    
    @objc func buttonAction() {
        let vc = PeopleDetailViewController()
        if let navController = self.navigationController {
            vc.modalPresentationStyle = .fullScreen
            navController.pushViewController(vc, animated: true)
        }
        else{
            self.present(vc, animated: true, completion: nil)
        }
    }

}
