//
//  PeopleFeatureTests.swift
//  PeopleFeatureTests
//
//  Created by Daniel Bastidas Ramirez on 13/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import XCTest
import PeopleFeatureData
import RxSwift
import RxTest

@testable import PeopleFeature

class PeopleFeatureTests: XCTestCase {
    
    //MARK:- TEST VIEW MODEL WITH SUCCESS DATA
    func testViewModelWithElements() {
        let disposableBag = DisposeBag()
        let testScheduler = TestScheduler(initialClock: 0)
        let testObserver = testScheduler.createObserver([PersonCellViewModel].self)
        let testInput = [
            PersonEntity(id: "", firstName: "Name", lastName: "LastName", avatar: "url", jobTitle: "job", email: "email", phone: "phone", favouriteColor: "color"),
            PersonEntity(id: "", firstName: "Name", lastName: "LastName", avatar: "url", jobTitle: "job", email: "email", phone: "phone", favouriteColor: "color"),
            PersonEntity(id: "", firstName: "Name", lastName: "LastName", avatar: "url", jobTitle: "job", email: "email", phone: "phone", favouriteColor: "color")
        ]
        
        // GIVEN DATA SUCCESS
        let getPeopleUseCase = MockPeopleUseCaseSuccess(testInput: testInput)
        let getImageUseCase = MockGetImageSuccess()
        let peopleViewModel = PeopleViewModel(getPeopleUseCase: getPeopleUseCase, getPersonImageUseCase: getImageUseCase)
        
        // WHEN CALL FETCH DATA
        peopleViewModel.peopleList
            .subscribe(testObserver)
            .disposed(by: disposableBag)
        
        peopleViewModel.fetchData()
        
        // THEN DISPLAY ELEMENTS
        let output = testObserver.events[0].value.element!
        XCTAssertEqual(testObserver.events.count, 1)
        XCTAssertEqual(output.count, testInput.count)
        
    }
    
    //MARK:- TEST VIEW MODEL WITH ERROR DATA
    func testViewModelWithError() {
        let disposableBag = DisposeBag()
        let testScheduler = TestScheduler(initialClock: 0)
        let testObserver = testScheduler.createObserver(Error.self)
        
        // GIVEN DATA WITH ERROR
        let error = ErrorBag.testingError
        let getPeopleUseCase = MockPeopleUseCaseError(error: error)
        let getImageUseCase = MockGetImageSuccess()
        let peopleViewModel = PeopleViewModel(getPeopleUseCase: getPeopleUseCase, getPersonImageUseCase: getImageUseCase)
        
        // WHEN CALL FETCH DATA
        peopleViewModel.error
            .subscribe(testObserver)
            .disposed(by: disposableBag)
        
        peopleViewModel.fetchData()
        
        // THEN DISPLAY ERROR VIEW
        let output = testObserver.events[0].value.element!
        
        XCTAssertEqual(output.localizedDescription, error.localizedDescription)
    }

}


// MARK:- MOCK CLASSES

enum ErrorBag:Error {
    case testingError
}

extension ErrorBag: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .testingError:
            return NSLocalizedString("ERROR IN TEST", comment: "TestError")
        }
    }
}

struct MockPeopleUseCaseSuccess: GetPeopleUseCaseProtocol {
    
    let testInput: [PersonEntity]
    
    func getPeopleResult() -> Observable<[PersonEntity]> {
        return Observable.just(testInput)
    }
}

struct MockPeopleUseCaseError: GetPeopleUseCaseProtocol {
    
    let error: Error
    
    func getPeopleResult() -> Observable<[PersonEntity]> {
        return Observable.error(error)
    }
}

struct MockGetImageSuccess: GetPersonImageUseCaseProtocol {
    func getPersonImageResult(imageUrl: String) -> Observable<UIImage> {
        return Observable.just(UIImage())
    }
}
