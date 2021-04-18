//
//  ACDataSource.swift
//  Staqo
//
//  Created by SHAILY on 04/04/21.
//

import Foundation

protocol ACDataSourceDelegate {
    func bookedRoom(completion:@escaping(StaoqResult<[BRVModel]>) -> Void)
    func approveCancel(bookingId:Int,roomStatus:String, approvedBy:String, userType:String,cancelBy: String, cancelRemark: String,completion:@escaping(StaoqResult<BaseModel>) -> Void)
    
    


}
class ACDataSource: ACDataSourceDelegate {
    func approveCancel(bookingId:Int,roomStatus:String, approvedBy:String, userType:String,cancelBy: String, cancelRemark: String, completion: @escaping (StaoqResult<BaseModel>) -> Void) {
        NetworkClient.request(target: ResourceType.approveCancel(bookingId: bookingId, roomStatus: roomStatus, approvedBy: approvedBy, userType: userType, cancelBy:cancelBy,cancelRemark:cancelRemark), success: { result in
            completion(result as StaoqResult<BaseModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }

    
    func bookedRoom(completion: @escaping (StaoqResult<[BRVModel]>) -> Void) {
        NetworkClient.request(target: ResourceType.bookedRoom, success: { result in
            completion(result as StaoqResult<[BRVModel]>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
    
}
