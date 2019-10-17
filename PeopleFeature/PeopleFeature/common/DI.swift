//
//  DI.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 15/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import Swinject
import PeopleFeatureData

struct DependencyManager {
  
    private let DI = Container(){ container in
        
        container.register(Navigation.self) { r in
            return Navigation()
        }

        container.register(PeopleViewModel.self) { r in
            return PeopleViewModel()
        }
        
        // DATA
        container.register(PeopleRepository.self) { r in
            return PeopleRepository()
        }

        // DOMAIN
        container.register(GetPeopleUseCase.self) { r in
            let repository = r.resolve(PeopleRepository.self)!
            return GetPeopleUseCase(repository: repository)
        }

        container.register(GetPersonImageUseCase.self) { r in
            let repository = r.resolve(PeopleRepository.self)!
            return GetPersonImageUseCase(repository: repository)
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

    func setPersonDetailViewModel(person:PersonEntity)  {
        DI.register(PersonDetailViewModel.self) { r in
            return PersonDetailViewModel(person: person)
        }
    }
}

let DIManager = DependencyManager()


