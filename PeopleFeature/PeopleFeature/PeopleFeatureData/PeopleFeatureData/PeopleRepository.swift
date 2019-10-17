//
//  PeopleRepository.swift
//  PeopleFeatureData
//
//  Created by Daniel Bastidas Ramirez on 17/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation
import UIKit

public struct PeopleRepository {
    
    let URLBase = "https://5cc736f4ae1431001472e333.mockapi.io/api/v1/people"
    
    public init(){}
    
    /**
     This *function* Returns the encapsulation of the People GET REQUEST
     - Parameter completion : Function
     - returns: URLSessionTask? -> Result<[PersonEntity],Error>
    */
    public func fetchPeople(completion: @escaping (Result<[PersonEntity],Error>) -> ()) -> URLSessionTask?{
        
        guard let url = URL(string: URLBase) else {return nil}
        
        return URLSession.shared.dataTask(with: url){ (data, resp, err) in
            
            if let err = err {
                completion(
                    .failure(err)
                )
                return
            }
            
            guard let dataResponse = data else {
                completion(
                    .success([])
                )
                return
            }
            
            do{
                let rooms = try JSONDecoder().decode([PersonEntity].self, from: dataResponse)
                completion(
                    .success(rooms)
                )
            }
            catch let jsonErr{
                completion(
                    .failure(jsonErr)
                )
            }
        }
    }
    
    /**
     This *function* Returns the encapsulation of person image GET REQUEST
     - Parameter imageUrl : String
     - Parameter completion : Function
     - returns: URLSessionTask? -> UIImage
    */
    public func fetchImage(imageUrl:String ,completion: @escaping (Result<UIImage,Error>) -> ()) -> URLSessionTask?{
        
        guard let url = URL(string: imageUrl) else {return nil}
        
        return URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let err = error {
                completion(
                    .failure(err)
                )
                return
            }
            
            guard let dataResponse = data
                else {
                    completion(
                        .success(UIImage())
                    )
                    return
                }
            
            guard let image = UIImage(data: dataResponse)
                else{
                    completion(
                        .success(UIImage())
                    )
                    return
                }
            
            completion(
                .success(image)
            )
        }
    }
}
