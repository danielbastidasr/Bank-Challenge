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
    
    func navigateToDetail(from:UIViewController, paramViewModel:String) {
        
        DIManager.setPersonDetailViewModel(paramViewModel: paramViewModel)
        
        let vc = PeopleDetailViewController()
        if let navController = from.navigationController {
            vc.modalPresentationStyle = .fullScreen
            navController.pushViewController(vc, animated: true)
        }
        else{
            from.present(vc, animated: true, completion: nil)
        }
    }
    
}
