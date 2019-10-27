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
        
        //VIEW MODELS
        container.register(PeopleViewModel.self) { r in
            let getPeopleUseCase = r.resolve(GetPeopleUseCase.self)!
            let getPersonImageUseCase = r.resolve(GetPersonImageUseCase.self)!
            return PeopleViewModel(getPeopleUseCase: getPeopleUseCase,getPersonImageUseCase: getPersonImageUseCase)
        }
    }
    
    //MARK:- Register

      func setPersonDetailViewModel(person:Person)  {
          DI.register(PersonDetailViewModel.self) { r in
              let getImageUseCase = r.resolve(GetPersonImageUseCase.self)!
              return PersonDetailViewModel(person: person, getImageUseCase: getImageUseCase)
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
}

let DIManager = DependencyManager()


