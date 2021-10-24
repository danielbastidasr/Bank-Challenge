//
//  PeopleFeatureTests.swift
//  PeopleFeatureTests
//
//  Created by Daniel Bastidas Ramirez on 13/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import XCTest
import RxSwift

@testable import PeopleFeature

class PeopleFeatureTests: XCTestCase {
    
    func testFetchData_withSuccessResponse_ShouldGetStateWithData() {
        
        // GIVEN DATA SUCCESS
        let sut = makeSUT(with: .success)
        let spy = RxSpy(value: sut.state)
        
        // WHEN CALL FETCH DATA
        sut.fetchData()
        
        // THEN View State
        let viewModel = MockPeopleUseCaseSuccess.testInput.map { entity in
            PersonCellViewModel(person: entity.toPresentation(), getPersonImage: MockGetImageSuccess())
        }
        
        XCTAssertEqual(spy.stateList, [.success(.init(isLoading: true, isError: false, data: [])),
                                       .success(.init(isLoading: false, isError: false, data: viewModel))
                                      ]
        )
    }
    
    
    func testFetchData_withErrorResponse_ShouldGetStateWithError() {
        
        // GIVEN DATA with error
        let sut = makeSUT(with: .error)
        let spy = RxSpy(value: sut.state)
        
        // WHEN call fetch data
        sut.fetchData()
        
        // THEN View State
        XCTAssertEqual(spy.stateList, [.success(.init(isLoading: true, isError: false, data: [])),
                                       .success(.init(isLoading: false, isError: true, data: []))
                                      ]
        )
    }
    
    // MARK:- Utils
    private func makeSUT(with type: SUTType) ->  PeopleViewModel {
        let getPeopleUseCase: GetPeopleUseCaseProtocol
        
        switch type {
        case .success:
            getPeopleUseCase = MockPeopleUseCaseSuccess()
        case .error:
            getPeopleUseCase = MockPeopleUseCaseError()
        }
        
        let sut = PeopleViewModel(getPeopleUseCase: getPeopleUseCase, getPersonImageUseCase: MockGetImageSuccess())
        return sut
    }
    
    enum SUTType {
        case success
        case error
    }
    
    class RxSpy<T> {
        let disposeBag = DisposeBag()
        var stateList: [Result<T, MyError>] = []
        let value: Observable<T>
        
        init(value: Observable<T>) {
            self.value = value
            
            self.value.subscribe (
                onNext: { [weak self] state in
                    self?.stateList.append(.success(state))
                }, onError: { [weak self] _ in
                    self?.stateList.append(.failure(MyError()))
                }
            ).disposed(by: disposeBag)
        }
    }
    
    struct MyError: Error, Equatable {}
    
    struct MockPeopleUseCaseSuccess: GetPeopleUseCaseProtocol {
        
        static let testInput: [PersonEntity] = [
            PersonEntity(id: UUID().uuidString, firstName: "Name1", lastName: "LastName1", avatar: "url1", jobTitle: "job1", email: "email", phone: "phone", favouriteColor: "color"),
            PersonEntity(id: UUID().uuidString, firstName: "Name2", lastName: "LastName2", avatar: "url2", jobTitle: "job2", email: "email", phone: "phone", favouriteColor: "color"),
            PersonEntity(id: UUID().uuidString, firstName: "Name3", lastName: "LastName3", avatar: "url3", jobTitle: "job3", email: "email", phone: "phone", favouriteColor: "color"),
            PersonEntity(id: UUID().uuidString, firstName: "Name4", lastName: "LastName4", avatar: "url4", jobTitle: "job4", email: "email", phone: "phone", favouriteColor: "color")
         ]
        
        func getPeopleResult() -> Observable<[PersonEntity]> {
            return Observable.just(PeopleFeatureTests.MockPeopleUseCaseSuccess.testInput)
        }
    }

    struct MockPeopleUseCaseError: GetPeopleUseCaseProtocol {
        
        private let error: Error = NSError()
        
        func getPeopleResult() -> Observable<[PersonEntity]> {
            return Observable.error(error)
        }
    }

    struct MockGetImageSuccess: GetPersonImageUseCaseProtocol {
        func getPersonImageResult(imageUrl: String) -> Observable<UIImage> {
            return Observable.just(UIImage())
        }
    }

}
