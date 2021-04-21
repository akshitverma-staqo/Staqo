//
//  BookRoomViewModel.swift
//  Staqo
//
//  Created by SHAILY on 02/04/21.
//

import Foundation

class BookRoomViewModel: ViewModelType {
   
var delegate: ViewModelDelegate?
private let dataSource:BookRoomDataSourceDelegate?
init(dataSource: BookRoomDataSourceDelegate) {
    self.dataSource = dataSource
}

func bootstrap() {
    
}
    
        
        
    func roomBookService(roomId: Int, attendents: Int, fromDateTime: String, toDateTime: String, roomStatus: String, purpose: String, visitorType: String, roomType: String, arrangementType: String, notificationId: String, roomCode: String, recurringDay: String, bookedBy: String, roomfeatures: String, roomtypeid:String ){
            delegate?.willLoadData()
        dataSource?.bookRoom(roomId: roomId, attendents: attendents, fromDateTime: fromDateTime, toDateTime: toDateTime, roomStatus: roomStatus, purpose: purpose, visitorType: visitorType, roomType: roomType, arrangementType: arrangementType, notificationId: notificationId, roomCode: roomCode, recurringDay: recurringDay, bookedBy: bookedBy, roomfeatures:roomfeatures,roomtypeid :roomtypeid, completion: { [weak self] result in
                guard let ws = self else{return}
                switch result {
                
                case .success(let baseModel):
                    print(baseModel)
                  //ws.rows = baseModel
                  ws.delegate?.didLoadData()
                case .failure(let error):
                    ws.delegate?.didFail(error: error)
                }
            })
        }
        
     
   
        
    
    
}
