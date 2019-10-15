//
//  Dependencies.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 15/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import Swinject

struct DependencyManager {
    
    private let DI = Container(){ container in
        
        container.register(Navigation.self) { r in
            return Navigation()
        }

        container.register(RoomsViewModel.self) { r in
            return RoomsViewModel()
        }
        
        container.register(RoomDetailViewModel.self) { r in
            let param = r.resolve(RoomDetailParam.self)
            return RoomDetailViewModel(room: param)
        }
        
    }
    
    //MARK:- Resolve
    
    func resolveNavigation() -> Navigation? {
        DI.resolve(Navigation.self)
    }
    
    func resolveRoomsViewModel() -> RoomsViewModel? {
        DI.resolve(RoomsViewModel.self)
    }
    
    func resolveRoomDetailVieModel() -> RoomDetailViewModel? {
        DI.resolve(RoomDetailViewModel.self)
    }
    
    //MARK:- Register

    func setRoomDetailViewModel(paramViewModel:String)  {
        DI.register(RoomDetailParam.self) { r in
            RoomDetailParam(name: paramViewModel)
        }
    }
}

let DIManager = DependencyManager()







