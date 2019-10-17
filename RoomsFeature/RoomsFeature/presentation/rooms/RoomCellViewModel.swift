//
//  RoomCellViewModel.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 17/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import RoomsFeatureData

class RoomCellViewModel {
    let room: RoomEntity
    
    //Out
    var roomName = ""
    var roomOccupied = ""
    
    init(room:RoomEntity) {
        self.room = room
        self.roomName = room.name
        if(room.isOccupied){
            self.roomOccupied = "Room Occupied"
        }
        else{
            self.roomOccupied = "Room Available"
        }
    }
    
}
