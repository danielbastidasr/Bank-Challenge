//
//  EntitiesExt.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 27/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import RoomsFeatureData

extension RoomEntity{
    func toPresentation() -> Room {
        return Room(id: self.id, name: self.name, isOccupied: self.isOccupied)
    }
}
