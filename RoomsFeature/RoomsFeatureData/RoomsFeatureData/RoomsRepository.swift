//
//  Network.swift
//  RoomsFeatureData
//
//  Created by Daniel Bastidas Ramirez on 16/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import Foundation

public struct RoomsRepository {
    
    let URLBase = "https://5dd56c23ce4c300014402e6b.mockapi.io/fake/rooms"
    
    public init(){}
    
    public func fetchRooms(completion: @escaping (Result<[RoomEntity],Error>) -> ()) -> URLSessionTask?{
        
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
                let rooms = try JSONDecoder().decode([RoomEntity].self, from: dataResponse)
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
    
}
