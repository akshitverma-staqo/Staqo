//
//  LoginViewModel.swift
//  Staqo
//
//  Created by Esoft on 11/02/21.
//

import Foundation
import UIKit

class LoginViewModel: ViewModelType {
    
    var delegate: ViewModelDelegate?
    private let dataSource:LoginDataSourceDelegate?
    init(dataSource: LoginDataSourceDelegate) {
        self.dataSource = dataSource
    }
    func bootstrap() {
        self.getTokenSilently()
        
    }
     func signInAthentication(view:UIViewController){
        delegate?.willLoadData()
        
        AuthenticationManager.instance.getTokenInteractively(parentView:view) {[weak self] (token: String?, error: Error?)  in
            
                        guard let ws = self else{
                            return
                        }
            
            DispatchQueue.main.async {
              
                
                guard let accessToken = token, error == nil else {
                    ws.delegate?.didFail(error: CustomError.OtherError(error: error!))
                    return
                }
                UserDefaults.standard.setAccessToken(value: accessToken)
                ws.delegate?.didLoadData()
                // Signed in successfully
                // Go to welcome page
               
            }
        }
        

    }
    private func getTokenSilently(){
                AuthenticationManager.instance.getTokenSilently {[weak self] (token: String?, error: Error?)  in
        
                    guard let ws = self else{
                        return
                    }
                            DispatchQueue.main.async {
        
                                guard let accessToken = token, error == nil else {
                                    // If there is no token or if there's an error,
                                    // no user is signed in, so stay here
                                    ws.delegate?.didFail(error: CustomError.OtherError(error: error!))
                                    return
                                }
        
                                // Since we got a token, a user is signed in
                                // Go to welcome page
                                UserDefaults.standard.setAccessToken(value: accessToken)
                                ws.delegate?.didLoadData()
        
        
                                }
                        }
              //delegate?.didLoadData()
    }
    
}
