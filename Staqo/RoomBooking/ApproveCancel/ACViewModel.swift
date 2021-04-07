//
//  ACViewModel.swift
//  Staqo
//
//  Created by SHAILY on 04/04/21.
//

import Foundation
class ACViewModel: ViewModelType {
   
var delegate: ViewModelDelegate?
private let dataSource:ACDataSourceDelegate?
    var rows: [BRVModel]?
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
                ws.rows = baseModel
              //ws.rowsLocation = baseModel
              ws.delegate?.didLoadData()
               
            case .failure(let error):
                ws.delegate?.didFail(error: error)
            }
            
        })

    
}

}
