//
//  EmpDataSource.swift
//  Staqo
//
//  Created by SHAILY on 05/03/21.
//

import Foundation
protocol EmpDataSourceDeleate {
    func getEmployeeDataWithID(emailID: String, completion: @escaping(StaoqResult<BaseModel>) -> Void)
    func updateByEmpID(mobileNo:String, ID:String, completion:@escaping(StaoqResult<BaseModel>)-> Void)
    
    
}
class EmpDataSource: EmpDataSourceDeleate{
    func updateByEmpID(mobileNo: String,ID:String , completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.updateByEmpID(mobileNo: mobileNo, ID: ID), success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
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
