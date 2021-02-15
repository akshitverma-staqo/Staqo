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
        
    }
    
    
}
