//
//  LogTicketViewModel.swift
//  Staqo
//
//  Created by SHAILY on 01/04/21.
//

import Foundation
class LogTicketViewModel: ViewModelType {
   
    
   
    var delegate: ViewModelDelegate?
    var rows : [Categories]?
    var rowsSubCat : [Subcategories]?
    private let dataSource:LogTicketDataSourceDelegate?
    init(dataSource: LogTicketDataSourceDelegate) {
        self.dataSource = dataSource
    }
    
    func bootstrap() {
        getCatergoryData()
    }
    
    
    func ticketImageUpload(file: Data, ID:String){
        delegate?.willLoadData()
        dataSource?.ticketImageUpload(file: file, ID: ID, completion: {[weak self] result in
            guard let ws = self else{return}
            
            switch result {
            case .success(let baseModel):
                print(baseModel)
           ///   ws.rowsSubCat = baseModel.subcategories
              ws.delegate?.didLoadData()
            case .failure(let error):
                ws.delegate?.didFail(error: error)
            }
            
        })
    }
    
    func submitTicketData(value: String)
    {
        delegate?.willLoadData()
        dataSource?.submitTicketData(value: value, completion: {[weak self] result in
            guard let ws = self else{return}
            
            switch result {
            case .success(let baseModel):
                print(baseModel)
           ///   ws.rowsSubCat = baseModel.subcategories
              ws.delegate?.didLoadData()
            case .failure(let error):
                ws.delegate?.didFail(error: error)
            }
            
        })
    }
    
    func getSubCatType(ID:String){
          
      delegate?.willLoadData()
      dataSource?.getSubCatData(ID:ID ,completion: {[weak self] result in
          guard let ws = self else{return}
          
          switch result {
          case .success(let baseModel):
              print(baseModel)
            ws.rowsSubCat = baseModel.subcategories
            ws.delegate?.didLoadData()
          case .failure(let error):
              ws.delegate?.didFail(error: error)
          }
          
      })

}
    
    
  
    
    func getCatergoryData(){
          
      delegate?.willLoadData()
      dataSource?.getCatData(completion: {[weak self] result in
          guard let ws = self else{return}
          
          switch result {
          case .success(let baseModel):
              print(baseModel)
            ws.rows = baseModel.categories
            ws.delegate?.didLoadData()
             
          case .failure(let error):
              ws.delegate?.didFail(error: error)
          }
          
      })

}
}
