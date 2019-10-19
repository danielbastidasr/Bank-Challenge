//
//  Navigation.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 15/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import UIKit

struct Navigation {
    
    func navigateToDetail(from:UIViewController, personCellViewModel:PersonCellViewModel) {
        
        DIManager.setPersonDetailViewModel(person: personCellViewModel.getPerson())
        
        let vc = PersonDetailViewController()
        if let navController = from.navigationController {
            vc.modalPresentationStyle = .fullScreen
            navController.pushViewController(vc, animated: true)
        }
        else{
            from.present(vc, animated: true, completion: nil)
        }
    }
    
}
