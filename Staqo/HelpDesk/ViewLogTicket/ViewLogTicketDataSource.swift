//
//  ViewLogTicketDataSource.swift
//  Staqo
//
//  Created by SHAILY on 01/04/21.
//

import Foundation

protocol ViewLogTicketDataSourceDelegate {
    func getTicket(completion:@escaping(StaoqResult<BaseModel>) -> Void)
    
}

class ViewLogTicketDataSource: ViewLogTicketDataSourceDelegate {
    func getTicket(completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.getTicket, success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
}
