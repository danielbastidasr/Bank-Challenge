//
//  GetPersonImageUseCase.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 17/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import RxSwift

protocol GetPersonImageUseCaseProtocol {
    func getPersonImageResult(imageUrl:String) -> Observable<UIImage>
}

class GetPersonImageUseCase:GetPersonImageUseCaseProtocol {
    
    private let repository:PeopleRepository
    
    init(repository:PeopleRepository) {
        self.repository = repository
    }
    
    func getPersonImageResult(imageUrl:String) -> Observable<UIImage> {

        Observable.create { observer in
            let task = self.repository.fetchImage(imageUrl: imageUrl) {(result) in
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
