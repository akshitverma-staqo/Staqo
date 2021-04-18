//
//  BookRoomDataSource.swift
//  Staqo
//
//  Created by SHAILY on 02/04/21.
//

import Foundation
protocol BookRoomDataSourceDelegate {
    func bookRoom(roomId:Int ,attendents:Int ,fromDateTime:String,toDateTime:String,roomStatus:String,purpose:String,visitorType: String,roomType:String,arrangementType:String,notificationId:String,roomCode:String,recurringDay:String,bookedBy:String,completion:@escaping(StaoqResult<BRVModel>) -> Void)

}
class BookRoomDataSource: BookRoomDataSourceDelegate {
    func bookRoom(roomId: Int, attendents: Int, fromDateTime: String, toDateTime: String, roomStatus: String, purpose: String, visitorType: String, roomType: String, arrangementType: String, notificationId: String, roomCode: String, recurringDay: String, bookedBy: String, completion: @escaping (StaoqResult<BRVModel>) -> Void) {
        NetworkClient.request(target: ResourceType.bookRoom(roomId: roomId, attendents: attendents, fromDateTime:fromDateTime , toDateTime: toDateTime, roomStatus: roomStatus, purpose: purpose, visitorType: visitorType, roomType: roomType, arrangementType: arrangementType, notificationId: notificationId, roomCode: roomCode, recurringDay: recurringDay, bookedBy: bookedBy), success: { result in
            completion(result as StaoqResult<BRVModel>)
            }, error: { (error) in
                completion(StaoqResult.failure(error))
            }) { (moyaError) in
            completion(StaoqResult.failure(moyaError))
            }
    }
    
   
}



