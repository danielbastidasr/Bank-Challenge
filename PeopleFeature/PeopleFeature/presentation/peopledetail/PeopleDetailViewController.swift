//
//  PeopleDetailViewController.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 13/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import UIKit

class PeopleDetailViewController: View {
    
    var personViewModel:PersonDetailViewModel?
    
    private let personName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        return lbl
    }()
    func resolveDI() {
        personViewModel = DIManager.resolvePersonDetailViewModel()
    }
    
    func setUpViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(personName)
        personName.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0, enableInsets: false)
    }
    
    func bindData() {
        personName.text = personViewModel?.person?.name
    }
}
