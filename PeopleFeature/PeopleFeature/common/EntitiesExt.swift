//
//  EntitiesExt.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 27/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation

extension PersonEntity{
    func toPresentation() -> Person {
        return Person(id: self.id, firstName: self.firstName, lastName: self.lastName, avatar: self.avatar, jobTitle: self.jobTitle, email: self.email, phone: self.phone, favouriteColor: self.favouriteColor)
    }
}
