//
//  RoomBookingViewModel.swift
//  Staqo
//
//  Created by SHAILY on 24/03/21.
//

import Foundation

class RoomBookingViewModel: ViewModelType {
   
    var arrangModel:[ArrangmentModel]?
    var rows:[RoomModel]?
    var rowsRoom:[RoomType]?
    var rowsLocation:[Location]?
    var delegate: ViewModelDelegate?
    private let dataSource:RoomDataSourceDelegate?
    init(dataSource: RoomDataSourceDelegate) {
        self.dataSource = dataSource
    }
    
    func bootstrap() {
        self.getAllRoomData()
       self.getRoomLocation()
       self.getRoomType()
        self.getArrangmentType()
    }
    
    func getAllRoomData(){
          
      delegate?.willLoadData()
      dataSource?.roomData(completion: {[weak self] result in
          guard let ws = self else{return}
          
          switch result {
          case .success(let baseModel):
              print(baseModel)
            ws.rows = baseModel
            ws.delegate?.didLoadData()
          case .failure(let error):
              ws.delegate?.didFail(error: error)
          }
          
      })
        
    }
        
        func getRoomLocation(){
              
          delegate?.willLoadData()
          dataSource?.roomLocation(completion: {[weak self] result in
              guard let ws = self else{return}
              
              switch result {
              case .success(let baseModel):
                  print(baseModel)
                ws.rowsLocation = baseModel
                ws.delegate?.didLoadData()
                 
              case .failure(let error):
                  ws.delegate?.didFail(error: error)
              }
              
          })

}
    
    func getRoomType(){
          
      delegate?.willLoadData()
      dataSource?.roomType(completion: {[weak self] result in
          guard let ws = self else{return}
          
          switch result {
          case .success(let baseModel):
              print(baseModel)
            ws.rowsRoom = baseModel
              ws.delegate?.didLoadData()
          case .failure(let error):
              ws.delegate?.didFail(error: error)
          }
          
      })

}
    
    
    func getArrangmentType(){
          
      delegate?.willLoadData()
      dataSource?.roomArrangment(completion: {[weak self] result in
          guard let ws = self else{return}
          
          switch result {
          case .success(let baseModel):
              print(baseModel)
            ws.arrangModel = baseModel
              ws.delegate?.didLoadData()
          case .failure(let error):
              ws.delegate?.didFail(error: error)
          }
          
      })

}

}
