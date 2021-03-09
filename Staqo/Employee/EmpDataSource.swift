//
//  EmpDataSource.swift
//  Staqo
//
//  Created by SHAILY on 05/03/21.
//

import Foundation
protocol EmpDataSourceDeleate {
    func getEmployeeDataWithID(emailID: String, completion: @escaping(StaoqResult<BaseModel>) -> Void)
//    func <#name#>(<#parameters#>) -> <#return type#> {
//    <#function body#>
//    }
    
    
}
class EmpDataSource: EmpDataSourceDeleate{
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
