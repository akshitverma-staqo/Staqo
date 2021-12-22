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
    func submitTicketData(desc: String, subj: String, catID: String, prioName: String, subID: String, email_ID: String, projName: String,completion:@escaping(StaoqResult<HelpdeskModel>) -> Void )
    func getCompanyData(completion: @escaping (StaoqResult<[ProjectModel]>) -> Void)
    func ticketImageUpload(file: String, ID:String, fileName: String,completion:@escaping(StaoqResult<BaseModel>) -> Void )
}
class LogTicketDataSource: LogTicketDataSourceDelegate {
    func ticketImageUpload(file: String, ID: String, fileName: String, completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.ticketImageUpload(file: file, ID: ID, fileName: fileName), success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
    func submitTicketData(desc: String, subj: String, catID: String, prioName: String, subID: String, email_ID: String, projName: String, completion: @escaping (StaoqResult<HelpdeskModel>) -> Void) {
        NetworkClient.request(target: ResourceType.submitTicketData(desc: desc, subj: subj, catID: catID, prioName: prioName, subID: subID, email_ID: email_ID, projName: projName), success: { result in
            completion(result as StaoqResult<HelpdeskModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
    func getCompanyData(completion: @escaping (StaoqResult<[ProjectModel]>) -> Void) {
        NetworkClient.request(target: ResourceType.getCompanyData, success: { result in
            completion(result as StaoqResult<[ProjectModel]>)
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


