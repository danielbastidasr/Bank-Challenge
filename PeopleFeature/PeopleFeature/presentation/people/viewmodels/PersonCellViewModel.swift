//
//  PersonCellViewModel.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 17/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import PeopleFeatureData
import RxSwift

class PersonCellViewModel {
    
    //Out
    let fullName:String
    let jobTitle:String
    let image:PublishSubject<UIImage> = PublishSubject()
    
    private let person:Person
    private let imageUrl:String
    private let getPersonImage:GetPersonImageUseCaseProtocol
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
    
    func getImage() {
        getPersonImage.getPersonImageResult(imageUrl: imageUrl)
        .subscribe(onNext: { [unowned self](image) in
            self.image.onNext(image)
        }, onError: { [unowned self](error) in
            self.image.onNext(UIImage())
        }).disposed(by: disposable)
    }
}

