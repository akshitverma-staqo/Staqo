//
//  ViewLogTicketViewModel.swift
//  Staqo
//
//  Created by SHAILY on 01/04/21.
//

import Foundation

class ViewLogTicketViewModel: ViewModelType {
   
    
    var rowsRequests:[Requests]?
//    var statusRows: Status?
  //  var createdTimeRows: Created_time?
    var delegate: ViewModelDelegate?
    private let dataSource:ViewLogTicketDataSourceDelegate?
    init(dataSource: ViewLogTicketDataSourceDelegate) {
        self.dataSource = dataSource
    }
    
    func bootstrap() {
        getTicketData()
    }
    
    func getTicketData(){
          
      delegate?.willLoadData()
      dataSource?.getTicket(completion: {[weak self] result in
          guard let ws = self else{return}
          
          switch result {
          case .success(let baseModel):
              print(baseModel)
            ws.rowsRequests = baseModel.allrequests?.requests
//            baseModel.allrequests?.requests?.forEach({ value in
//                ws.statusRows = value.status
//            })
            ws.delegate?.didLoadData()
             
          case .failure(let error):
              ws.delegate?.didFail(error: error)
          }
          
      })

}

}
