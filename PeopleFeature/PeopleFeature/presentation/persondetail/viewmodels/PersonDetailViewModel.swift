//
//  PersonDetailViewModel.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 15/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import PeopleFeatureData
import UIKit

class PersonDetailViewModel{

    private let person:PersonEntity
    
    //Out
    let personName:String
    let occupation:String
    let email:String
    let telephone:String
    let favColor:UIColor
    
    init(person:PersonEntity) {
        self.person = person
        self.personName = "\(person.firstName) \(person.lastName)"
        self.occupation = person.jobTitle
        self.email = person.email
        self.telephone = person.phone
        self.favColor = UIColor(hex: person.favouriteColor)
    }
}
