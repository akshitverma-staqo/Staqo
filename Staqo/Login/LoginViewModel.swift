//
//  LoginViewModel.swift
//  Staqo
//
//  Created by Esoft on 11/02/21.
//

import Foundation

class LoginViewModel: ViewModelType {
    
    var delegate: ViewModelDelegate?
    private let dataSource:LoginDataSourceDelegate?
    init(dataSource: LoginDataSourceDelegate) {
        self.dataSource = dataSource
    }
    func bootstrap() {
        self.signInAthentication()
    }
    private func signInAthentication(){
        delegate?.willLoadData()
        
        AuthenticationManager.instance.getTokenSilently {[weak self] (token: String?, error: Error?)  in

            guard let ws = self else{
                return
            }
                    DispatchQueue.main.async {

                        guard let _ = token, error == nil else {
                            // If there is no token or if there's an error,
                            // no user is signed in, so stay here
                            ws.delegate?.didFail(error: CustomError.OtherError(error: error!))
                            return
                        }

                        // Since we got a token, a user is signed in
                        // Go to welcome page
                        ws.delegate?.didLoadData()

                        }
                }
      //delegate?.didLoadData()
    }
    
    
}
