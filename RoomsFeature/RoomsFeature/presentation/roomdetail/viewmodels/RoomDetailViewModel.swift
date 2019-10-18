//
//  RoomDetailViewModel.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 15/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import RoomsFeatureData
import UIKit

class RoomDetailViewModel{
    
    //OUT
    let roomDetail:String
    let roomName:String
    let textColor:UIColor
    
    private let room:RoomEntity?
    
    init(room:RoomEntity) {
        
        self.room = room
        self.roomName = room.name
        
        if(room.isOccupied){
            self.roomDetail = "This room is currently Occupied"
            self.textColor = .systemRed
        }
        else{
            self.roomDetail = "This room is currently Available"
            self.textColor = .systemGreen
        }
    }
}
