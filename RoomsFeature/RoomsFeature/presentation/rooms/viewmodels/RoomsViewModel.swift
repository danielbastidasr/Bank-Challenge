//
//  RoomsViewModel.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 15/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import RxSwift
import RoomsFeatureData

class RoomsViewModel{
    
    private let useCase:GetRoomsUseCaseProtocol
    
    // OUT
    var listRooms:PublishSubject<[RoomCellViewModel]> = PublishSubject()
    var loading:PublishSubject<Bool> = PublishSubject()
    var error:PublishSubject<Error> = PublishSubject()
    
    let disposableBag = DisposeBag()
    
    init(useCase:GetRoomsUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchData() {
        useCase.getRoomsResult()
            .map({ (rooms) -> [RoomCellViewModel] in
                var roomCells:[RoomCellViewModel] = []
                
                rooms.forEach { (room) in
                    roomCells.append(RoomCellViewModel(room: room))
                }
                return roomCells
            })
            .subscribe(onNext: { [unowned self](rooms) in
                self.listRooms.onNext(rooms)
            }, onError: { (error) in
                self.error.onNext(error)
            })
            .disposed(by: disposableBag)
    }
    
}
