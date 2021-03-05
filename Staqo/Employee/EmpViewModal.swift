//
//  EmpViewModal.swift
//  Staqo
//
//  Created by SHAILY on 05/03/21.
//

import Foundation

class EmpViewModal: ViewModelType {
   
    
    
    var delegate: ViewModelDelegate?
    private let dataSource:EmpDataSourceDeleate?
    init(dataSource: EmpDataSourceDeleate) {
        self.dataSource = dataSource
    }
    
        
    func bootstrap() {
        self.getEmployeeDataWithID(emailID: UserDefaults.standard.getEmail())
    }
    
    func getEmployeeDataWithID(emailID: String){
        
        delegate?.willLoadData()
        dataSource?.getEmployeeDataWithID(emailID: emailID, completion: { [weak self] result in
            guard let ws = self else {return }
            DispatchQueue.main.async {
                switch result{
                
                case .success(let baseModal):
                    print(baseModal)
                    ws.delegate?.didLoadData()
                case .failure(let error):
                    ws.delegate?.didFail(error: error)
                    
                }
            }
        })
    }
}
