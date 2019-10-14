//
//  View.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 14/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import UIKit

protocol ViewProtocol {
    func setUpViews()
    func bindData()
}

class BaseViewController : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    func setup() {
        guard let controller = self as? View else {
            return
        }
        controller.setUpViews()
        controller.bindData()
    }
}

typealias View = BaseViewController & ViewProtocol
