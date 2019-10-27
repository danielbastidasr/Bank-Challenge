//
//  Extensions.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 14/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import UIKit
import RxSwift

extension UIView {
 
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
    
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        let insets = self.safeAreaInsets
         
        topInset = insets.top
        bottomInset = insets.bottom
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
         
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
         
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
         
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
     
}

class ViewModelProtocol<T> {
    
    //OUT
    let state:PublishSubject<ViewState<T>> = PublishSubject()
    
    private final func onReduceState(viewAction: Action<T>) -> ViewState<T>{
        switch viewAction {
            case .LoadState(let dataEmpty):
                return ViewState<T>(isLoading: true, isError: false, data: dataEmpty)
            
            case .DataLoadingFailure(let dataInCaseFailed):
                return ViewState<T>(isLoading: false, isError: true, data: dataInCaseFailed)
                
            case .DataLoadingSuccess(let data):
                return ViewState<T>(isLoading: false, isError: false, data: data)
        }
    }
    
    final func sendAction(viewAction:Action<T>){
        state.onNext(
            onReduceState(viewAction: viewAction)
        )
    }
}

struct ViewState<T>{
    var isLoading: Bool
    var isError: Bool
    var data: T
    
    init(isLoading:Bool, isError:Bool, data:T) {
        self.data = data
        self.isLoading = isLoading
        self.isError = isError
    }
}

enum Action<T> {
    case LoadState( dataEmpty: T )
    case DataLoadingSuccess( data: T)
    case DataLoadingFailure( dataInCaseFailed: T)
}

