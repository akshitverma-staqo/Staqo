//
//  BusinessDataSource.swift
//  Staqo
//
//  Created by SHAILY on 16/03/21.
//

import Foundation
protocol BusinessDataSourceDelegate {
    func getTextReader(value:String, completion:@escaping(StaoqResult<BaseModel>) -> Void )
}

class BusinessDataSource: BusinessDataSourceDelegate {
    func getTextReader(value: String, completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.getTextReader(value: value), success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
   

}
