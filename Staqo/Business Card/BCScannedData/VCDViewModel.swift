//
//  VCDViewModel.swift
//  Staqo
//
//  Created by SHAILY on 18/04/21.
//

import Foundation
class VCDViewModel: ViewModelType {
  
    var delegate: ViewModelDelegate?
    private var dataSource:VCDDataSourceDelegate?
    init(dataSource:VCDDataSourceDelegate) {
        self.dataSource = dataSource
    }
    func bootstrap() {
    
    }
    
    func visitSaveData(email:String , empID:Int, name:String , cmpName:String , webSite:String,address:String, mobileNo:String,remark:String,scanBy:String){
        delegate?.willLoadData()
        dataSource?.visitSaveData(email: email, empID: empID, name: name, cmpName: cmpName, webSite: webSite, address: address, mobileNo: mobileNo, remark: remark, scanBy: scanBy, completion: { [weak self] result in
            guard let ws = self else { return}
            switch result {
            
            case .success(let baseModel):
                ws.delegate?.didLoadData()
            case .failure(let error):
                ws.delegate?.didFail(error: error)
                
            }
        })
    }
}
