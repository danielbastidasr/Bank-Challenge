//
//  RoomCellViewModel.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 17/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import UIKit
import RoomsFeatureData

class RoomCellViewModel {
    
    //Out
    var roomName = ""
    var roomOccupied = ""
    var textColor:UIColor = .systemGreen
    
    let room: RoomEntity
    private let availableColor:UIColor = .systemGreen
    private let accupiedColor:UIColor = .systemRed
    
    
    init(room:RoomEntity) {
        self.room = room
        self.roomName = room.name
        if(room.isOccupied){
            self.roomOccupied = "Room Occupied"
            self.textColor = self.accupiedColor
        }
        else{
            self.roomOccupied = "Room Available"
            self.textColor = self.availableColor
        }
    }
    
}
