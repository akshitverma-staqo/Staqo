//
//  HomeDataSource.swift
//  Staqo
//
//  Created by SHAILY on 18/02/21.
//

import Foundation

protocol HomeDataSourceDelegate {
    func dashboardMeneData(completion:@escaping(StaoqResult<BaseModel>) -> Void)
    func profile(completion:@escaping(DownloadResult) -> Void)
}
class HomeDataSource: HomeDataSourceDelegate{
    func profile(completion: @escaping (DownloadResult) -> Void) {
    
    }
    
    func dashboardMeneData(completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.dashboardMeneData, success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
    
}
