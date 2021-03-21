//
//  MunroViewController.swift
//  Bank Challenge
//
//  Created by Daniel Bastidas Ramirez on 21/03/2021.
//  Copyright © 2021 Daniel Bastidas. All rights reserved.
//

import UIKit
import SwiftUI
import MunroFilterFeature

class MunroViewController: UIViewController {
    let controller = UIHostingController(rootView: MunroFeatureView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
