//
//  NotificationDataSource.swift
//  Staqo
//
//  Created by SHAILY on 26/03/21.
//

import Foundation
protocol NotificationDataSourceDelegate {
    func notificationData(email:String,completion:@escaping(StaoqResult<BaseModel>) -> Void)
    func readNotification(email:String,  completion:@escaping(StaoqResult<[ReadNotify]>) -> Void)
    func addNotification(ID:String,notifyID:String, email:String, flag:String ,completion:@escaping(StaoqResult<BaseModel>) -> Void)
   
}

class NotificationDataSource: NotificationDataSourceDelegate {
    func addNotification(ID: String, notifyID: String, email: String, flag: String, completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.addNotification(ID: ID, notifyID: notifyID, email: email, flag: flag), success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }    }
    
    func readNotification(email: String, completion: @escaping (StaoqResult<[ReadNotify]>) -> Void) {
        NetworkClient.request(target: ResourceType.readNotification(email: email), success: { result in
            completion(result as StaoqResult<[ReadNotify]>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
    func notificationData(email:String,completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.notificationData(email:email), success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
}
