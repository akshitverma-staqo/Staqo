//
//  LogTicketDataSource.swift
//  Staqo
//
//  Created by SHAILY on 01/04/21.
//

import Foundation
protocol LogTicketDataSourceDelegate {
    func getCatData(completion:@escaping(StaoqResult<BaseModel>) -> Void)
    func getSubCatData(ID:String, completion:@escaping(StaoqResult<BaseModel>) -> Void )
    func submitTicketData(value:String,completion:@escaping(StaoqResult<BaseModel>) -> Void )
    
    func ticketImageUpload(file: Data, ID:String,completion:@escaping(StaoqResult<BaseModel>) -> Void )
}
class LogTicketDataSource: LogTicketDataSourceDelegate {
    func ticketImageUpload(file: Data, ID: String, completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.ticketImageUpload(file: file, ID: ID), success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }

    }
    
    func submitTicketData(value: String, completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.submitTicketData(value: value), success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
    func getSubCatData(ID: String, completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.getSubCatData(ID: ID), success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
    func getCatData(completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.getCatData, success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
    
}
