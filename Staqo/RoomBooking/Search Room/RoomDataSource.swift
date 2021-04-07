//
//  RoomDataSource.swift
//  Staqo
//
//  Created by SHAILY on 24/03/21.
//

import Foundation
protocol RoomDataSourceDelegate {
    func roomData(ID:String,completion:@escaping(StaoqResult<[RoomModel]>) -> Void)
    func roomLocation(completion:@escaping(StaoqResult<[Location]>) -> Void)
    func roomType(completion:@escaping(StaoqResult<[RoomType]>) -> Void)
    func roomArrangment(ID:String,completion:@escaping(StaoqResult<[ArrangmentModel]>) -> Void)
    func searchRoom(value :String, completion:@escaping(StaoqResult<BaseModel>) -> Void)

}

class RoomDataSource: RoomDataSourceDelegate {
    func searchRoom(value :String,completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.searchRoom(value: value), success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
   
    func roomArrangment(ID:String,completion: @escaping (StaoqResult<[ArrangmentModel]>) -> Void) {
        NetworkClient.request(target: ResourceType.roomArrangment(ID: ID), success: { result in
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
    
    
    
    func roomData(ID:String ,completion: @escaping (StaoqResult<[RoomModel]>) -> Void) {
        NetworkClient.request(target: ResourceType.roomData(ID: ID), success: { result in
            completion(result as StaoqResult<[RoomModel]>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
 
    
    
   
    
   
}
