//
//  BookRoomDataSource.swift
//  Staqo
//
//  Created by SHAILY on 02/04/21.
//

import Foundation
protocol BookRoomDataSourceDelegate {
    func bookRoom(roomId:Int ,attendents:Int ,fromDateTime:String,toDateTime:String,roomStatus:String,purpose:String,visitorType: String,roomType:String,arrangementType:String,notificationId:String,roomCode:String,recurringDay:String,bookedBy:String,roomfeatures: String,roomtypeid: String, completion:@escaping(StaoqResult<BRVModel>) -> Void)
   func roomImages(url:String,completion:@escaping(DownloadResult) -> Void)

}
class BookRoomDataSource: BookRoomDataSourceDelegate {
    func roomImages(url: String, completion: @escaping (DownloadResult) -> Void) {
        _ =  NetworkClient.request(target:.roomImages(url: url), progress:  { progress in
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
    
    func bookRoom(roomId: Int, attendents: Int, fromDateTime: String, toDateTime: String, roomStatus: String, purpose: String, visitorType: String, roomType: String, arrangementType: String, notificationId: String, roomCode: String, recurringDay: String, bookedBy: String, roomfeatures: String,roomtypeid: String, completion: @escaping (StaoqResult<BRVModel>) -> Void) {
        NetworkClient.request(target: ResourceType.bookRoom(roomId: roomId, attendents: attendents, fromDateTime:fromDateTime , toDateTime: toDateTime, roomStatus: roomStatus, purpose: purpose, visitorType: visitorType, roomType: roomType, arrangementType: arrangementType, notificationId: notificationId, roomCode: roomCode, recurringDay: recurringDay, bookedBy: bookedBy, roomfeatures:roomfeatures, roomtypeid:roomtypeid), success: { result in
            completion(result as StaoqResult<BRVModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
   
}



