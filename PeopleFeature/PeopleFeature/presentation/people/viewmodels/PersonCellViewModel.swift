//
//  PersonCellViewModel.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 17/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import RxSwift

struct  PersonCellViewModel: Equatable {
    static func == (lhs: PersonCellViewModel, rhs: PersonCellViewModel) -> Bool {
        lhs.person == rhs.person 
    }
    
    //Out
    let fullName:String
    let jobTitle:String
    var image:Observable<UIImage> {
        getPersonImage.getPersonImageResult(imageUrl: imageUrl)
            .catchError { _ in
                .just(UIImage())
            }
    }
    
    private let person: Person
    private let imageUrl: String
    private let getPersonImage: GetPersonImageUseCaseProtocol
    private let disposable = DisposeBag()
    
    init(person:Person, getPersonImage:GetPersonImageUseCaseProtocol) {
        self.getPersonImage = getPersonImage
        self.person = person
        self.fullName = "\(person.firstName) \(person.lastName)"
        self.imageUrl = person.avatar
        self.jobTitle = person.jobTitle
    }
    
    func getPerson() -> Person {
        return person
    }
}

