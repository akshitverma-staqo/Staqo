//
//  ACViewModel.swift
//  Staqo
//
//  Created by SHAILY on 04/04/21.
//

import Foundation
protocol ACViewModelDelegate:class {
    func getBookedData(status:String)
}
class ACViewModel: ViewModelType {
    var _delegate:ACViewModelDelegate?
var delegate: ViewModelDelegate?
private let dataSource:ACDataSourceDelegate?
    var rows: [BRVModel]?
    var rows1: [BRVModel]?
init(dataSource: ACDataSourceDelegate) {
    self.dataSource = dataSource
}

func bootstrap() {
    getBookedRoomData()
    
}
    
    func getBookedRoomData(){
          
        delegate?.willLoadData()
        dataSource?.bookedRoom(completion: {[weak self] result in
            guard let ws = self else{return}
            
            switch result {
            case .success(let baseModel):
                print(baseModel)
                //    ws.rows = baseModel
              //  ws.rows1 = baseModel
                let filterData = baseModel.filter{$0.roomStatus == "a" || $0.roomStatus == "A" }
                let filterData1 = baseModel.filter{$0.roomStatus == "p" || $0.roomStatus == "P"}
                ws.rows = filterData
                ws.rows1 = filterData1
               
              //ws.rowsLocation = baseModel
              ws.delegate?.didLoadData()
               
            case .failure(let error):
                ws.delegate?.didFail(error: error)
            }
            
        })

    
}

    func approveCancel(bookingId:Int,roomStatus:String, approvedBy:String, userType:String,cancelBy: String, cancelRemark: String,status:String){
        delegate?.willLoadData()
        dataSource?.approveCancel(bookingId: bookingId, roomStatus: roomStatus, approvedBy: approvedBy, userType: userType, cancelBy:cancelBy,cancelRemark:cancelRemark, completion: { [weak self] result in
            guard let ws = self else{return}
            switch result {
            
            case .success(let baseModel):
                ws._delegate?.getBookedData(status: status)
            case .failure(let error):
                
                ws.delegate?.didFail(error: error)
            }
        })
    }
    
    
}
