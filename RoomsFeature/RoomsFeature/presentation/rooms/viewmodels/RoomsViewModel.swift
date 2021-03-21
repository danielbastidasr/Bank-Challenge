//
//  RoomsViewModel.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 15/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import RxSwift

class RoomsViewModel:ViewModelProtocol<[RoomCellViewModel]>{
    
    private let useCase:GetRoomsUseCaseProtocol
    private let disposableBag = DisposeBag()
    
    init(useCase:GetRoomsUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchData() {
        self.sendAction(viewAction:
            .LoadState(dataEmpty: [])
        )
        useCase.getRoomsResult()
            .map({ (rooms) -> [RoomCellViewModel] in
                var roomCells:[RoomCellViewModel] = []
                
                rooms.forEach { (room) in
                    roomCells.append(RoomCellViewModel(room: room.toPresentation()))
                }
                return roomCells
            })
            .subscribe(onNext: { [unowned self](rooms) in
                self.sendAction(viewAction:
                    .DataLoadingSuccess(data: rooms)
                )
            }, onError: { (error) in
                self.sendAction(viewAction:
                    .DataLoadingFailure(dataInCaseFailed: [])
                )
            })
            .disposed(by: disposableBag)
    }
    
}
