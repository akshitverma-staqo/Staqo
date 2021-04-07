//
//  ACDataSource.swift
//  Staqo
//
//  Created by SHAILY on 04/04/21.
//

import Foundation

protocol ACDataSourceDelegate {
    func bookedRoom(completion:@escaping(StaoqResult<[BRVModel]>) -> Void)
    

}
class ACDataSource: ACDataSourceDelegate {
    func bookedRoom(completion: @escaping (StaoqResult<[BRVModel]>) -> Void) {
        NetworkClient.request(target: ResourceType.bookedRoom, success: { result in
            completion(result as StaoqResult<[BRVModel]>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
    
}
