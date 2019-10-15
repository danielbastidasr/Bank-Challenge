//
//  Common.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 14/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import UIKit

extension UIView {
 
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
    
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        let insets = self.safeAreaInsets
         
        topInset = insets.top
        bottomInset = insets.bottom
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
         
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
         
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
         
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
     
}

protocol ViewProtocol {
    func resolveDI()
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
        controller.resolveDI()
        controller.setUpViews()
        controller.bindData()
    }
    
}

typealias View = BaseViewController & ViewProtocol
