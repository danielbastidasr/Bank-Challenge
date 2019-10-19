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
    public let favouriteColor:String
}
