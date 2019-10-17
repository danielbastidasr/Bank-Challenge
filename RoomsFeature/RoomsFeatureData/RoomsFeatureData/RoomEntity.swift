//
//  RoomEntity.swift
//  RoomsFeatureData
//
//  Created by Daniel Bastidas Ramirez on 17/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation

public struct RoomEntity:Decodable {
    public let id:String
    public let name:String
    public let isOccupied:Bool
}
