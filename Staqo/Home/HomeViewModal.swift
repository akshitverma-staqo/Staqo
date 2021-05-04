//
//  HomeViewModal.swift
//  Staqo
//
//  Created by SHAILY on 18/02/21.
//

import Foundation
import MSGraphClientModels
import MSAL
import MSGraphClientSDK


protocol HomeViewModalDelegate:class {
func callImage()
}
class HomeViewModal:ViewModelType{

    var rows : [MenuModel]? // (imageArr:[String], curveArr:[String], TopLabArray:[String])?
    private let dataSource: HomeDataSourceDelegate?
    var delegate: ViewModelDelegate?
    var _delegate:HomeViewModalDelegate?
    var imgValue:Bool = true
    var errorLog:ErrorLog?
    init(dataSource: HomeDataSourceDelegate) {
        self.dataSource = dataSource
    }
    func bootstrap() {
     //   self.scrollImage()
        self.getGraphData()
        self.getImage()
        self.dashboardData()
    }
    
    func dashboardData(){
          
      delegate?.willLoadData()
      dataSource?.dashboardMeneData(completion: {[weak self] result in
          guard let ws = self else{return}
          
          switch result {
          case .success(let baseModel):
              print(baseModel)
           
            let filterData = baseModel.filter{$0.status == "Active"}
            ws.rows = filterData
            for item in 0..<(ws.rows?.count ?? 0) {
                if ws.imgValue {
                    ws.rows?[item].isSelected = false
                    ws.imgValue = false
                }else{
                    ws.rows?[item].isSelected = true
                    ws.imgValue = true
                }
                
            }
            
              ws.delegate?.didLoadData()
          case .failure(let error):
           // ws.errorLog = error
              ws.delegate?.didFail(error: error)
          }
          
      })

}
    
    func getGraphData() {
        delegate?.willLoadData()
        GraphManager.instance.getMe {
            (user: MSGraphUser?, error: Error?) in
            
            DispatchQueue.main.async { [self] in
                
                
                guard let currentUser = user, error == nil else {
                    print("Error getting user: \(String(describing: error))")
                    delegate?.didFail(error: CustomError.OtherError(error: error!))
                    return
                }
                let data = MSGraphData(email: currentUser.mail ?? "", name: currentUser.displayName ?? "", mobileNo1: currentUser.mobilePhone ?? "", jobDesignation: currentUser.jobTitle ?? "" , businessPhone: currentUser.businessPhones.first  as? String ?? "", givenName: currentUser.givenName ?? "" )

                UserDefaults.standard.setProfile(value: data)
                delegate?.didLoadData()
                
            }
        }
        
    }
    func getImage()  {
     
        dataSource?.profile(fileName:"profile", completion: { [weak self] result in
            guard let ws = self else{return}
            switch result {
            
            case .progress(_):
                print("Downloading")
            case .success(let baseModel):
                UserDefaults.standard.setProfileImage(value: baseModel)
                ws._delegate?.callImage()
            
            case .failure(let error):
                UserDefaults.standard.setProfileImage(value: Data())
                ws._delegate?.callImage()
                //ws.delegate?.didFail(error: error)
            }
        })
    }
}
