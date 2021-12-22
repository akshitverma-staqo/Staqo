//
//  HomeDataSource.swift
//  Staqo
//
//  Created by SHAILY on 18/02/21.
//

import Foundation

protocol HomeDataSourceDelegate {
    func dashboardMeneData(completion:@escaping(StaoqResult<[MenuModel]>) -> Void)
    func profile(fileName:String,completion:@escaping(DownloadResult) -> Void)
    func fcmUpdateData(ID: String,fcmID: String, completion: @escaping(StaoqResult<BaseModel>) -> Void)

}
class HomeDataSource: HomeDataSourceDelegate{
    func fcmUpdateData(ID: String, fcmID: String, completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.fcmUpdate(ID: ID, fcmID: fcmID), success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    

    
    
  
    
    func profile(fileName: String, completion: @escaping ((DownloadResult) -> Void)) {
        _ =  NetworkClient.request(target:.download(fileName: fileName), progress:  { progress in
                     }){ downloadresult in
             switch downloadresult {
                         case .progress(_):
                 print("downloading....")
             case .success(let result):
                completion(DownloadResult.success(result))
             case .failure(let error):
                completion(DownloadResult.failure(error))
             }
    }
    

    }
    
    func dashboardMeneData(completion: @escaping (StaoqResult<[MenuModel]>) -> Void) {
        NetworkClient.request(target: ResourceType.dashboardMeneData, success: { result in
            completion(result as StaoqResult<[MenuModel]>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
    
}
