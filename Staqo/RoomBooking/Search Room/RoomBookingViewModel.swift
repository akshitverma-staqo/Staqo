//
//  RoomBookingViewModel.swift
//  Staqo
//
//  Created by SHAILY on 24/03/21.
//

import Foundation
protocol RoomBookingViewModelDelegate: class {
    func updatedResult(data:BaseModel?)
}
class RoomBookingViewModel: ViewModelType {
   
    var arrangModel:[ArrangmentModel]?
    var rows:[RoomModel]?
    var rowsRoom:[RoomType]?
    var rowsLocation:[Location]?
    var delegate: ViewModelDelegate?
    var _delegate:RoomBookingViewModelDelegate?
    private let dataSource:RoomDataSourceDelegate?
    init(dataSource: RoomDataSourceDelegate) {
        self.dataSource = dataSource
    }
    
    func bootstrap() {
        
        self.getRoomLocation()
        self.getRoomType()
    }
    
    func getAllRoomData(ID:String){
          
      delegate?.willLoadData()
      dataSource?.roomData(ID:ID ,completion: {[weak self] result in
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
    
    
    func getArrangmentType(ID:String){
          
      delegate?.willLoadData()
      dataSource?.roomArrangment(ID:ID ,completion: {[weak self] result in
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

    
    func searchRoomData(value:String){
            delegate?.willLoadData()
            dataSource?.searchRoom(value: value, completion: { [weak self] result in
                guard let ws = self else{return}
                switch result {
                
                case .success(let baseModel):
                    print(baseModel)
                    ws._delegate?.updatedResult(data: baseModel)
                  //  ws.delegate?.didLoadData()
                case .failure(let error):
                    ws.delegate?.didFail(error: error)
                }
                
            })
       

}
}
