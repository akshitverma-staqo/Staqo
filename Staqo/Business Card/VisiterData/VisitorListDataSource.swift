//
//  VisitorListDataSource.swift
//  Staqo
//
//  Created by SHAILY on 15/03/21.
//

import Foundation
protocol VisitorListDataSourceDelegare {
    func getVisiterListData(ID: String, completion: @escaping(StaoqResult<BaseModel>) -> Void)
    
    
}
class VisitorListDataSource: VisitorListDataSourceDelegare{
   
    
    
    func getVisiterListData(ID: String, completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        
        
        let url = Configuration.baseURL + Constant.kSiteID + Constant.kVISITOR_LIST + ID + Constant.kVisiterList1
        NetworkClient.requestAlmofire(passToUrl: url, passToMethod: .get, passToParameter:nil , passToHeader: ["Authorization":"Bearer " + UserDefaults.standard.getAccessToken(), "Content-Type":"application/json"]) { result in
              completion(result as StaoqResult<BaseModel>)
          } error: { (error) in
              completion(StaoqResult.failure(error))
          } failure: { (failure) in
              print(failure)
          }
        
//        NetworkClient.request(target: ResourceType.getVisiterListData(ID: ID), success: { result in
//            completion(result as StaoqResult<BaseModel>)
//            }, error: { (error) in
//                completion(StaoqResult.failure(error))
//            }) { (moyaError) in
//            completion(StaoqResult.failure(moyaError))
//            }
    }
    
    
    
}
