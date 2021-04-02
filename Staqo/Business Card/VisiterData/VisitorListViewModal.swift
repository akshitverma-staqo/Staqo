//
//  VisitorListViewModal.swift
//  Staqo
//
//  Created by SHAILY on 15/03/21.
//

import Foundation


class VisiterListViewModal: ViewModelType {
   
    
    var delegate: ViewModelDelegate?
     var field: Fields?
     var valueData:Value?
     private let dataSource:VisitorListDataSourceDelegare?
     init(dataSource: VisitorListDataSourceDelegare) {
         self.dataSource = dataSource
     }
    func bootstrap() {
        self.getEmployeeDataWithID(emailID: UserDefaults.standard.getProfile()?.email ?? "")
    }
    
  private func getEmployeeDataWithID(emailID: String){
        
        delegate?.willLoadData()

    //        dataSource?.getVisiterListData(emailID: emailID, completion: { [weak self] result in
//            guard let ws = self else {return }
//            DispatchQueue.main.async {
//                switch result{
//
//                case .success(let baseModel):
//                    print(baseModel)
//
//                    if baseModel.value?.count == 0  {
//
//                    }else{
//                        baseModel.value?.forEach({data in
//                            ws.valueData = data
//                            ws.field = data.fields
//                        })
//                        ws.delegate?.didLoadData()
//                    }
//
//                case .failure(let error):
//                    ws.delegate?.didFail(error: error)
//
//                }
//            }
//        })
    }
    
}
