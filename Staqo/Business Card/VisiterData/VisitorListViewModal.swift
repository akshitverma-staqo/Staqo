//
//  VisitorListViewModal.swift
//  Staqo
//
//  Created by SHAILY on 15/03/21.
//

import Foundation


class VisiterListViewModal: ViewModelType {
   
    
    var delegate: ViewModelDelegate?
     var field: [Fields]?
     var valueData:[Value]?
     private let dataSource:VisitorListDataSourceDelegare?
     init(dataSource: VisitorListDataSourceDelegare) {
         self.dataSource = dataSource
     }
    func bootstrap() {
        
    }
    
  func getVisitorList(ID: String){
        
        delegate?.willLoadData()
    dataSource?.getVisiterListData(ID: ID, completion: { [weak self] result in
            guard let ws = self else {return }
            DispatchQueue.main.async {
                switch result{

                case .success(let baseModel):
                    print(baseModel)

                    if baseModel.value?.count == 0  {

                    }else{
                        ws.valueData = baseModel.value
                        ws.delegate?.didLoadData()
                    }

                case .failure(let error):
                    ws.delegate?.didFail(error: error)

                }
            }
        })
    }
    
}
