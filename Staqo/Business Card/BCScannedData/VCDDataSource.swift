//
//  VCDDataSource.swift
//  Staqo
//
//  Created by SHAILY on 18/04/21.
//

import Foundation

protocol VCDDataSourceDelegate {
    func visitSaveData(email:String , empID:Int, name:String , cmpName:String , webSite:String,address:String, mobileNo:String,remark:String,scanBy:String, completion:@escaping(StaoqResult<BaseModel>)-> Void)
}
class VCDDataSource:VCDDataSourceDelegate{
    func visitSaveData(email: String, empID: Int, name: String, cmpName: String, webSite: String, address: String, mobileNo: String, remark: String, scanBy: String, completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        let jsonreq: [String: Any]   = ["fields": ["Title":email,"emailid":email,"employeeidLookupId":empID,"name":name,"companyname":cmpName,"websitename":webSite,"addressline1":address,"mobileno1":mobileNo,"remarks":remark,"scanby":scanBy]]
        
        let url = Configuration.baseURL + Constant.kSiteID + Constant.kVISITOR_DUPLICATE + email + Constant.kVISITOR_DUPLICATE1
        NetworkClient.requestAlmofire(passToUrl: url, passToMethod: .post, passToParameter:jsonreq  , passToHeader: ["Authorization":"Bearer " + UserDefaults.standard.getAccessToken(), "Content-Type":"application/json"]) { result in
              completion(result as StaoqResult<BaseModel>)
          } error: { (error) in
              completion(StaoqResult.failure(error))
          } failure: { (failure) in
              print(failure)
          }
        
    }

}
