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
    func insertEmpData(email:String , orgID:Int, name:String , fcmToken:String , desig:String,mobileNo:String, completion:@escaping(StaoqResult<BaseModel>)-> Void)
    func deleteEmp(ID:String,completion:@escaping(StaoqResult<BaseModel>)-> Void)
    
}

class EmpDataSource: EmpDataSourceDeleate{
    func deleteEmp(ID:String,completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        let jsonreq: [String: Any]   = ["mobileno2":""]
        let url = Configuration.baseURL + Constant.kSiteID + Constant.kEMPLOYEE_FIND_BY_ID + "\(ID)" + "/fields"
        NetworkClient.requestAlmofire(passToUrl: url, passToMethod: .patch, passToParameter: jsonreq, passToHeader: ["Authorization":"Bearer " + UserDefaults.standard.getAccessToken(), "Content-Type":"application/json"]) { result in
            
            completion(result as StaoqResult<BaseModel>)
            
        } error: { (error) in
            completion(StaoqResult.failure(error))
        } failure: { (failure) in
            print(failure)
        }
    }
    
    func insertEmpData(email: String, orgID: Int, name: String, fcmToken: String, desig: String, mobileNo: String, completion: @escaping (StaoqResult<BaseModel>) -> Void) {
//        NetworkClient.request(target: ResourceType.insertEmpData(email: email, orgID: orgID, name: name, fcmToken: fcmToken, desig: desig, mobileNo: mobileNo), success: { result in
//            completion(result as StaoqResult<BaseModel>)
//            }, error: { (error) in
//                completion(StaoqResult.failure(error))
//            }) { (moyaError) in
//            completion(StaoqResult.failure(moyaError))
//            }
        
        let jsonreq: [String: Any]   = ["fields": ["Title":email,"organizationidLookupId":orgID,"name":name,"ipaddress":fcmToken,"designation":desig,"department":"IT","emailid":email,"mobileno1":mobileNo]]
//
       // let url = Constant.kBaseUrl + Constant.kSiteID + Constant.kEMPLOYEE_REGISTER
        let url =  "https://graph.microsoft.com/v1.0/sites/347d2bb7-7c8d-4d31-8d34-783763ab8ccb/lists/Employee%20Master/items"
        NetworkClient.requestAlmofire(passToUrl: url, passToMethod: .post, passToParameter:jsonreq  , passToHeader: ["Authorization":"Bearer " + UserDefaults.standard.getAccessToken(), "Content-Type":"application/json"]) { result in
            completion(result as StaoqResult<BaseModel>)
        } error: { (error) in
            completion(StaoqResult.failure(error))
        } failure: { (failure) in
            print(failure)
        }
        
    }
    
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
        let url = Configuration.baseURL + Constant.kSiteID + Constant.kEMPLOYEE_FOR_ID + emailID + "'"
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
