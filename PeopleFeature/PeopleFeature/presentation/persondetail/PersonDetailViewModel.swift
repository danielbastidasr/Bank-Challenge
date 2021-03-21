//
//  PersonDetailViewModel.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 15/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class PersonDetailViewModel{

    private let person:Person
    private let disposable = DisposeBag()
    private let getImageUseCase:GetPersonImageUseCase
    private let imageUrl:String
    
    //Out
    let personName:String
    let occupation:String
    let email:String
    let telephone:String
    let favColor:UIColor
    let image:PublishSubject<UIImage> = PublishSubject()
    lazy var accessibilityHint = "Telephone: \(telephone). \n Email: \(email)"
    lazy var accessibilityLabel = "\(personName) information:"
    
    init(person:Person, getImageUseCase:GetPersonImageUseCase) {
        self.imageUrl = person.avatar
        self.getImageUseCase = getImageUseCase
        self.person = person
        self.personName = "\(person.firstName) \(person.lastName)"
        self.occupation = person.jobTitle
        self.email = person.email
        self.telephone = person.phone
        self.favColor = UIColor(hex: person.favouriteColor)
    }
    
    func getImage() {
        getImageUseCase.getPersonImageResult(imageUrl: imageUrl)
        .subscribe(onNext: { [unowned self](image) in
            self.image.onNext(image)
        }, onError: { [unowned self](error) in
            self.image.onNext(UIImage())
        }).disposed(by: disposable)
    }
}
