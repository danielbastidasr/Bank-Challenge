//
//  PeopleFeatureTests.swift
//  PeopleFeatureTests
//
//  Created by Daniel Bastidas Ramirez on 13/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import PeopleFeature

class PeopleFeatureTests: XCTestCase {
    
    var disposableBag = DisposeBag()
    var testScheduler = TestScheduler(initialClock: 0)
    lazy var testObserver = testScheduler.createObserver(ViewState<[PersonCellViewModel]>.self)
    
    
    //MARK:- TEST VIEW MODEL WITH SUCCESS DATA
    func testViewModelWithElements() {
        
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
        peopleViewModel.state
            .subscribe(testObserver)
            .disposed(by: disposableBag)
        
        peopleViewModel.fetchData()
        
        // THEN 2 EVENTS TRIGGERED
        XCTAssertEqual(testObserver.events.count, 2)
        
        // FIRST EVENT DISPLAY LOADING
        let outputLoading = testObserver.events[0].value.element!
        XCTAssert(outputLoading.isLoading)
        
        // SECOND EVENT DISPLAY DATA FETCHED
        let outputData = testObserver.events[1].value.element!
        XCTAssert(!outputData.isLoading)
        XCTAssertEqual(outputData.data.count, testInput.count)
    }
    
    //MARK:- TEST VIEW MODEL WITH ERROR DATA
    func testViewModelWithError() {
        
        // GIVEN DATA WITH ERROR
        let error = ErrorBag.testingError
        let getPeopleUseCase = MockPeopleUseCaseError(error: error)
        let getImageUseCase = MockGetImageSuccess()
        let peopleViewModel = PeopleViewModel(getPeopleUseCase: getPeopleUseCase, getPersonImageUseCase: getImageUseCase)
        
        // WHEN CALL FETCH DATA
        peopleViewModel.state
            .subscribe(testObserver)
            .disposed(by: disposableBag)
        
        peopleViewModel.fetchData()
       
        // THEN 2 EVENTS TRIGGERED
        XCTAssertEqual(testObserver.events.count, 2)

        // FIRST EVENT DISPLAY LOADING
        let outputLoading = testObserver.events[0].value.element!
        XCTAssert(outputLoading.isLoading)

        // SECOND EVENT DISPLAY DATA FETCHED
        let outputData = testObserver.events[1].value.element!
        XCTAssert(!outputData.isLoading)
        XCTAssert(outputData.isError)
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
