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
    let peopleList:PublishSubject<[PersonCellViewModel]> = PublishSubject()
    var loading:PublishSubject<Bool> = PublishSubject()
    var error:PublishSubject<Error> = PublishSubject()
    
    private let getPeopleUseCase:GetPeopleUseCase
    private let getPersonImageUseCase: GetPersonImageUseCase
    private let disposableBag = DisposeBag()
    
    init(getPeopleUseCase:GetPeopleUseCase, getPersonImageUseCase:GetPersonImageUseCase) {
        self.getPeopleUseCase = getPeopleUseCase
        self.getPersonImageUseCase = getPersonImageUseCase
    }
    
    func fetchData() {
        getPeopleUseCase.getPeopleResult()
            .map({ (people) -> [PersonCellViewModel] in
                var personCells:[PersonCellViewModel] = []
                people.forEach {[unowned self] (person) in
                    let pvm = PersonCellViewModel(person: person, getPersonImage: self.getPersonImageUseCase)
                    personCells.append(pvm)
                }
                return personCells
            })
            .subscribe(onNext: { [unowned self](people) in
                self.peopleList.onNext(people)
            }, onError: {[unowned self] (error) in
                self.error.onNext(error)
            })
            .disposed(by: disposableBag)
    }    
}



