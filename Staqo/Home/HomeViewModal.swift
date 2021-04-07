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

class HomeViewModal:ViewModelType{

    var rows : [MenuModel]? // (imageArr:[String], curveArr:[String], TopLabArray:[String])?
    private let dataSource: HomeDataSourceDelegate?
    var delegate: ViewModelDelegate?
    var imgValue:Bool = true
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
              ws.delegate?.didFail(error: error)
          }
          
      })

}

    
    
//    private func scrollImage(){
//
//        rows = (["set1","set2","salmeenicon","bcimage","dashboard6","dashboard7","dashboard8","dashboard9","dashboard10"],["blob1.png","blob2.png","blob1.png","blob2.png","blob1.png","blob2.png","blob1.png","blob2.png","blob1.png"],["OQ Portal","Mazzayacom","Salmeen","Business Card","Helpdesk","IHSSE","E-SIGN","Travel & Leave Request","Majalis"])
//
//
//
//
//
//        delegate?.didLoadData()
//    }
    
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
                let data = MSGraphData(email: currentUser.mail ?? "", name: currentUser.displayName ?? "", mobileNo1: currentUser.mobilePhone ?? "", jobDesignation: currentUser.jobTitle ?? "" , businessPhone: currentUser.businessPhones.first  as? String ?? "")

                UserDefaults.standard.setProfile(value: data)
                delegate?.didLoadData()
                
            }
        }
        
    }
    func getImage()  {
        
        dataSource?.profile(fileName:"profile", completion: { [weak self] result in
            guard let ws = self else{return}
            if  result {
                
            }
        })
    }
}
