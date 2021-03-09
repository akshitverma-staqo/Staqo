//
//  EmpViewModal.swift
//  Staqo
//
//  Created by SHAILY on 05/03/21.
//

import Foundation

class EmpViewModal: ViewModelType {
   var delegate: ViewModelDelegate?
    var value:[Value]?
    private let dataSource:EmpDataSourceDeleate?
    init(dataSource: EmpDataSourceDeleate) {
        self.dataSource = dataSource
    }
    
        
    func bootstrap() {
        self.getEmployeeDataWithID(emailID: UserDefaults.standard.getProfile()?.email ?? "")
    }
    
  private func getEmployeeDataWithID(emailID: String){
        
        delegate?.willLoadData()
        dataSource?.getEmployeeDataWithID(emailID: emailID, completion: { [weak self] result in
            guard let ws = self else {return }
            DispatchQueue.main.async {
                switch result{
                
                case .success(let baseModal):
                    print(baseModal)
                    if baseModal.value?.count == 0  {
                        
                    }else{
                        ws.value = baseModal.value
                        ws.delegate?.didLoadData()
                    }
                    
                case .failure(let error):
                    ws.delegate?.didFail(error: error)
                    
                }
            }
        })
    }
    private func insertData(){
        delegate?.willLoadData()
        
    }
}
