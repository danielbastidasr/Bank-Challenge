//
//  PeopleViewModel.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 15/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import RxSwift
import PeopleFeatureData

class PeopleViewModel {
    
    //OUT
    let peopleList = Observable<[PersonCellViewModel]>.just([
        PersonCellViewModel(person: PersonEntity(id: "", firstName: "HELLOOO", lastName: "HEEEEEE", avatar: "ESSS", jobTitle: "SASDSADAS", email: "", phone: ""), getPersonImage: GetPersonImageUseCase(repository: PeopleRepository())),
        PersonCellViewModel(person: PersonEntity(id: "", firstName: "HELLOOO2", lastName: "HEEEEEE2222", avatar: "ES222SS", jobTitle: "SASDSA2222DAS", email: "", phone: ""), getPersonImage: GetPersonImageUseCase(repository: PeopleRepository()))
    ])
    
    let getPeopleUseCase:GetPeopleUseCase
    let getPersonImageUseCase: GetPersonImageUseCase
    
    init(getPeopleUseCase:GetPeopleUseCase, getPersonImageUseCase:GetPersonImageUseCase) {
        self.getPeopleUseCase = getPeopleUseCase
        self.getPersonImageUseCase = getPersonImageUseCase
    }
    
}



