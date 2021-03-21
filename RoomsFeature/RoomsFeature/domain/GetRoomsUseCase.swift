//
//  GetRoomsUseCase.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 17/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import RxSwift

protocol GetRoomsUseCaseProtocol {
    func getRoomsResult() -> Observable<[RoomEntity]>
}

class GetRoomsUseCase:GetRoomsUseCaseProtocol {
    
    private let repository:RoomsRepository
    
    init(repository:RoomsRepository) {
        self.repository = repository
    }
    
    func getRoomsResult() -> Observable<[RoomEntity]> {

        Observable.create { observer in
            let task = self.repository.fetchRooms {(result) in
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
