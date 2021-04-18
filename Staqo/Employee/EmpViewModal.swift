//
//  EmpViewModal.swift
//  Staqo
//
//  Created by SHAILY on 05/03/21.
//

import Foundation
protocol EmpViewModalDelegate:class {
    func getEmpID(ID:String)
}
protocol EmpRefreshDelegate:class {
    func getRefresh()
}
class EmpViewModal: ViewModelType {
   var delegate: ViewModelDelegate?
    var empDelegate:EmpRefreshDelegate?
    var _delegate:EmpViewModalDelegate?
    var field: Fields?
    var valueData:Value?
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
                
                case .success(let baseModel):
                    print(baseModel)
                   
                    if baseModel.value?.count == 0  {
                        ws.insertEmpData(email: UserDefaults.standard.getProfile()?.email ?? "", orgID: 2, name:UserDefaults.standard.getProfile()?.name ?? "", fcmToken: "", desig: UserDefaults.standard.getProfile()?.jobDesignation ?? "", mobileNo: UserDefaults.standard.getProfile()?.mobileNo1 ?? "")
                    }else{
                        baseModel.value?.forEach({data in
                            ws.valueData = data
                            ws.field = data.fields
                            
                        })
                        ws._delegate?.getEmpID(ID:ws.field?.id ?? "" )
                        UserDefaults.standard.setEmpID(value:ws.field?.id ?? "" )
                        ws.delegate?.didLoadData()
                    }
                    
                case .failure(let error):
                    ws.delegate?.didFail(error: error)
                    
                }
            }
        })
    }
    func updateByEmpID(mobileNo:String, ID:String){
        delegate?.willLoadData()
        dataSource?.updateByEmpID(mobileNo: mobileNo, ID: ID, completion: { [weak self] result in
            guard let ws = self else{return}
            DispatchQueue.main.async {
                switch result{
                case .success(let baseModel):
                    print(baseModel)
                    ws.field = baseModel.fieldsData
                    ws.delegate?.didLoadData()
                case .failure(let error):
                    ws.delegate?.didFail(error: error)
                }
            }
            
        })
    }
    
    private  func insertEmpData(email:String , orgID:Int, name:String , fcmToken:String , desig:String,mobileNo:String){
        delegate?.willLoadData()
        dataSource?.insertEmpData(email: email, orgID: orgID, name: name, fcmToken: fcmToken, desig: desig, mobileNo: mobileNo, completion: { [weak self] result in
            guard let ws = self else{return}
            DispatchQueue.main.async {
                switch result{
                case .success(let baseModel):
                    print(baseModel)
                    UserDefaults.standard.setEmpID(value:ws.field?.id ?? "" )
                    ws.empDelegate?.getRefresh()
                    ws.delegate?.didLoadData()
                case .failure(let error):
                    ws.delegate?.didFail(error: error)
                }
            }
            
        })
    }
}
