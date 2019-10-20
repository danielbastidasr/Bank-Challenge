//
//  GetPeopleUseCase.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 17/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import RxSwift
import PeopleFeatureData


protocol GetPeopleUseCaseProtocol {
    func getPeopleResult() -> Observable<[PersonEntity]>
}

class GetPeopleUseCase:GetPeopleUseCaseProtocol {
    
    private let repository:PeopleRepository
    
    init(repository:PeopleRepository) {
        self.repository = repository
    }
    
    func getPeopleResult() -> Observable<[PersonEntity]> {

        Observable.create { observer in
            let task = self.repository.fetchPeople {(result) in
                switch result {
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let result):
                        observer.onNext(result)
                }
            }
            
            task?.resume()
            
            return Disposables.create {
                task?.cancel()
            }
        }
        .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
}
