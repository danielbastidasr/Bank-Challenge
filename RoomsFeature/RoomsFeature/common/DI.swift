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

        // DATA
        container.register(RoomsRepository.self) { r in
            return RoomsRepository()
        }
        
        // DOMAIN
        container.register(GetRoomsUseCase.self) { r in
            let repository = r.resolve(RoomsRepository.self)!
            return GetRoomsUseCase(repository: repository)
        }
        
        // VIEWMODELS
        container.register(RoomsViewModel.self) { r in
            let useCase = r.resolve(GetRoomsUseCase.self)!
            return RoomsViewModel(useCase: useCase)
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

    func setRoomDetailViewModel(paramViewModel:Room)  {
        DI.register(RoomDetailViewModel.self) { r in
             RoomDetailViewModel(room: paramViewModel)
        }
    }
}

let DIManager = DependencyManager()







