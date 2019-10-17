//
//  PersonEntity.swift
//  PeopleFeatureData
//
//  Created by Daniel Bastidas Ramirez on 17/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation

public struct PersonEntity:Decodable {
    public let id:String
    public let firstName:String
    public let lastName:String
    public let avatar:String
    public let jobTitle:String
    public let email:String
    public let phone:String
    
    public init(id:String, firstName:String,lastName:String,avatar:String,jobTitle:String,email:String,phone:String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.jobTitle = jobTitle
        self.email = email
        self.phone = phone
    }
}
