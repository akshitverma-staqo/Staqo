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
        let url = "https://graph.microsoft.com/v1.0/sites/544d5eca-671c-4f65-9dbe-7d4b50b02b9c/lists/Employee%20Master/items/?$expand=fields&$filter=fields/emailid%20eq%20'oqtest2@staqo.com'"
        // let url = URL(fileURLWithPath:  "https://graph.microsoft.com/v1.0/sites/544d5eca-671c-4f65-9dbe-7d4b50b02b9c/lists/Employee%20Master/items/?$expand=fields&$filter=fields/emailid%20eq%20'oqtest2@staqo.com'")
            
        NetworkClient.requestAlmofire(passToUrl: url, passToMethod: .get, passToParameter: nil, passToHeader: ["Authorization":"Bearer " + UserDefaults.standard.getAccessToken(), "Content-Type":"application/json"]) { result in
            completion(result as StaoqResult<BaseModel>)
        } error: { (error) in
            completion(StaoqResult.failure(error))
        } failure: { (failure) in
            print(failure)
        }


//        NetworkClient.request(target: ResourceType.getEmployeeDataWithID(emailID: emailID), success: { result in
//            completion(result as StaoqResult<BaseModel>)
//            }, error: { (error) in
//                completion(StaoqResult.failure(error))
//            }) { (moyaError) in
//            completion(StaoqResult.failure(moyaError))
//            }
    }
    
    
}
