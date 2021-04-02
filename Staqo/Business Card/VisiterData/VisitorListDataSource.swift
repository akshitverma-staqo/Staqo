//
//  VisitorListDataSource.swift
//  Staqo
//
//  Created by SHAILY on 15/03/21.
//

import Foundation
protocol VisitorListDataSourceDelegare {
    func getEmployeeDataWithID(emailID: String, completion: @escaping(StaoqResult<BaseModel>) -> Void)
    
    
}
class VisitorListDataSource: VisitorListDataSourceDelegare{
    
    func getEmployeeDataWithID(emailID: String, completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.getEmployeeDataWithID(emailID: emailID), success: { result in
            completion(result as StaoqResult<BaseModel>)
            
            
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
    
    
}
