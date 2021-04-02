//
//  NotificationViewModel.swift
//  Staqo
//
//  Created by SHAILY on 26/03/21.
//

import Foundation
import UIKit

protocol NotificationViewModelDelegate:class {
    func didGetnotification()
}
protocol GetNotifyCountDelegate:class {
    func getNotifyCount()
}
class NotificationViewModel: ViewModelType {
    var delegate: ViewModelDelegate?
    var _delegate:NotificationViewModelDelegate?
    var delegateNotify:GetNotifyCountDelegate?
    var rows:[Value]?
    private let dataSource: NotificationDataSourceDelegate?
    init(dataSource: NotificationDataSourceDelegate) {
        self.dataSource = dataSource
    }
    
    
    func bootstrap() {
        getNotificationData()
        
    }
    
 private func getNotificationData(){
          
      delegate?.willLoadData()
      dataSource?.notificationData(completion: {[weak self] result in
          guard let ws = self else{return}
          
          switch result {
          case .success(let baseModel):
              print(baseModel)
            ws.rows = baseModel.value
            ws.readNotification(email: UserDefaults.standard.getProfile()?.email ?? "")
           //   ws.delegate?.didLoadData()
          case .failure(let error):
              ws.delegate?.didFail(error: error)
          }
          
      })

}
  private func readNotification(email: String){
        delegate?.willLoadData()
        dataSource?.readNotification(email: email, completion: { [weak self] result in
            guard let ws = self else{return}
            switch result {
            
            case .success(let baseModel):
                ws.delegate?.didLoadData()
                for notify in 0..<(baseModel.count ) {
                    for item in 0..<(ws.rows?.count ?? 0) {
                        if ws.rows?[item].fields?.id ?? "" == baseModel[notify].notificationid ?? ""{
                            ws.rows?[item].fields?.isRead =  true
                            }
                    }
                }
                ws.delegateNotify?.getNotifyCount()
                ws.delegate?.didLoadData()
            case .failure(let error):
                ws.delegate?.didFail(error: error)
            }
        })
    }
    
    
    func addNotification(ID: String, notifyID: String, email: String, flag: String ){
        delegate?.willLoadData()
        dataSource?.addNotification(ID: ID, notifyID: notifyID, email: email, flag: flag, completion: { [weak self] result in
            guard let ws = self else{return}
            switch result {
            
            case .success(let baseModel):
                ws._delegate?.didGetnotification()
            case .failure(let error):
                ws._delegate?.didGetnotification()
                ws.delegate?.didFail(error: error)
            }
        })
    }
}
