//
//  PersonCellViewModel.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 17/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import PeopleFeatureData

class PersonCellViewModel {
    
    let person:PersonEntity
    let getPersonImage:GetPersonImageUseCase
    
    //Out
    let fullName:String
    let imageUrl:String
    let jobTitle:String
    
    init(person:PersonEntity, getPersonImage:GetPersonImageUseCase) {
        self.getPersonImage = getPersonImage
        self.person = person
        self.fullName = "\(person.firstName) \(person.lastName)"
        self.imageUrl = person.avatar
        self.jobTitle = person.jobTitle
    }
    
}

