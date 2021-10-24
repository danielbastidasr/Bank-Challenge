//
//  PeopleViewModel.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 15/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import RxSwift

typealias PeopleViewModelState = [PersonCellViewModel]

class PeopleViewModel:ViewModelProtocol<PeopleViewModelState> {
    
    private let getPeopleUseCase:GetPeopleUseCaseProtocol
    private let getPersonImageUseCase: GetPersonImageUseCaseProtocol
    private let disposableBag = DisposeBag()
    
    init(getPeopleUseCase:GetPeopleUseCaseProtocol, getPersonImageUseCase:GetPersonImageUseCaseProtocol) {
        self.getPeopleUseCase = getPeopleUseCase
        self.getPersonImageUseCase = getPersonImageUseCase
    }
    
    func fetchData() {
        self.sendAction(viewAction:
            .LoadState(dataEmpty: [])
        )
        
        getDataParsed()
            .subscribe(onNext: { [unowned self](people) in
                self.sendAction(viewAction:
                    .DataLoadingSuccess(data: people)
                )
            }, onError: {[unowned self] (error) in
                self.sendAction(viewAction:
                    .DataLoadingFailure(dataInCaseFailed: [])
                )
            })
            .disposed(by: disposableBag)
    }
    
    private func getDataParsed() -> Observable<[PersonCellViewModel]>{
        getPeopleUseCase.getPeopleResult()
        .map({ (people) -> [PersonCellViewModel] in
            var personCells:[PersonCellViewModel] = []
            
            people.forEach {[unowned self] (person) in
                let pvm = PersonCellViewModel(person: person.toPresentation(), getPersonImage: self.getPersonImageUseCase)
                personCells.append(pvm)
            }
            
            return personCells
        })
    }
}



