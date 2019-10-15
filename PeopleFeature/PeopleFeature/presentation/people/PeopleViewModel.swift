//
//  PeopleViewModel.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 15/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import RxSwift

struct PeopleViewModel {
    let peopleList = Observable.just(["Hello","World","People"])
}
