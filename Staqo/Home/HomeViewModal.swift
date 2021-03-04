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

    var rows : (imageArr:[String], curveArr:[String], TopLabArray:[String])?
    private let dataSource: HomeDataSourceDelegate?
    var delegate: ViewModelDelegate?
    init(dataSource: HomeDataSourceDelegate) {
        self.dataSource = dataSource
    }
    func bootstrap() {
        self.scrollImage()
        self.getGraphData()
    }
    private func scrollImage(){

        rows = (["set1.png","set2.png","salmeenicon.png","bcimage.png"],["blob1.png","blob2.png","blob1.png","blob2.png"],["OQ Portal","Mazzayacom","Salmeen","Business Card"])
        
        delegate?.didLoadData()
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
               // UserDefaults.standard.setUserName(value: currentUser.displayName ?? "")
                //UserDefaults.standard.setUserID(value: currentUser.employeeId ?? "")
                UserDefaults.standard.setProfile(value: currentUser)
                delegate?.didLoadData()
                
            }
        }
        
    }
    
}
