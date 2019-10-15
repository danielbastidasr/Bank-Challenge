//
//  DI.swift
//  PeopleFeature
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

        container.register(PeopleViewModel.self) { r in
            return PeopleViewModel()
        }
    
        container.register(PersonDetailViewModel.self) { r in
            let param = r.resolve(PersonDetailParam.self)!
            return PersonDetailViewModel(person: param)
        }
        
    }
    
    //MARK:- Resolve
    
    func resolveNavigation() -> Navigation? {
        DI.resolve(Navigation.self)
    }
    
    func resolvePeopleViewModel() -> PeopleViewModel? {
        DI.resolve(PeopleViewModel.self)
    }
    
    func resolvePersonDetailViewModel() -> PersonDetailViewModel? {
        DI.resolve(PersonDetailViewModel.self)
    }
    
    //MARK:- Register

    func setPersonDetailViewModel(paramViewModel:String)  {
        DI.register(PersonDetailParam.self) { r in
            PersonDetailParam(name: paramViewModel)
        }
    }
}

let DIManager = DependencyManager()


