//
//  PersonEntity.swift
//  PeopleFeatureData
//
//  Created by Daniel Bastidas Ramirez on 17/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation

public struct PersonEntity:Decodable {
    let id:String
    let firstName:String
    let lastName:String
    let avatar:String
    let jobTitle:String
    let email:String
    let phone:String
}
