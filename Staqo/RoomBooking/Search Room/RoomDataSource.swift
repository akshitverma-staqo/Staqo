//
//  RoomDataSource.swift
//  Staqo
//
//  Created by SHAILY on 24/03/21.
//

import Foundation
protocol RoomDataSourceDelegate {
    func roomData(completion:@escaping(StaoqResult<[RoomModel]>) -> Void)
    func roomLocation(completion:@escaping(StaoqResult<[Location]>) -> Void)
    func roomType(completion:@escaping(StaoqResult<[RoomType]>) -> Void)
    func roomArrangment(completion:@escaping(StaoqResult<[ArrangmentModel]>) -> Void)

}

class RoomDataSource: RoomDataSourceDelegate {
   
    func roomArrangment(completion: @escaping (StaoqResult<[ArrangmentModel]>) -> Void) {
        NetworkClient.request(target: ResourceType.roomArrangment, success: { result in
            completion(result as StaoqResult<[ArrangmentModel]>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
   
    
    func roomType(completion: @escaping (StaoqResult<[RoomType]>) -> Void) {
        NetworkClient.request(target: ResourceType.roomType, success: { result in
            completion(result as StaoqResult<[RoomType]>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
    func roomLocation(completion: @escaping (StaoqResult<[Location]>) -> Void) {
        NetworkClient.request(target: ResourceType.roomLocation, success: { result in
            completion(result as StaoqResult<[Location]>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
    
    
    func roomData(completion: @escaping (StaoqResult<[RoomModel]>) -> Void) {
        NetworkClient.request(target: ResourceType.roomData, success: { result in
            completion(result as StaoqResult<[RoomModel]>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
 
    
    
   
    
   
}
