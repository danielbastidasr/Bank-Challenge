//
//  RoomEntity.swift
//  RoomsFeatureData
//
//  Created by Daniel Bastidas Ramirez on 17/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation

public struct RoomEntity:Decodable {
    let id:String
    let name:String
    let isOccupied:Bool
}
