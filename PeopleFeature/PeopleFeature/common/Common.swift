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
    
    let errorView : UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        

     let errorButton : UIButton = {
         let button = UIButton()
         button.backgroundColor = .black
         button.setTitle("Please Retry", for: .normal)
         return button
     }()
    
    private let errorLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "There was an error"
        label.textAlignment = .center
        return label
    }()

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
        setUpErrorView()
    }
    
    private func setUpErrorView(){
        let errorStack = UIStackView(arrangedSubviews: [errorLabel,errorButton])
        errorStack.distribution = .fillEqually
        errorStack.axis = .vertical
        errorStack.spacing = 40
        
        errorView.addSubview(errorStack)
        view.addSubview(errorView)
        
        errorStack.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 150, enableInsets: false)
        
        errorStack.centerXAnchor.constraint(equalTo: errorView.centerXAnchor).isActive = true
        errorStack.centerYAnchor.constraint(equalTo: errorView.centerYAnchor).isActive = true
        
        errorView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        errorView.isHidden = true
    }
    
}

typealias View = BaseViewController & ViewProtocol
