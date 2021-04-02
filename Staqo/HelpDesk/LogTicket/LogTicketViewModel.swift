//
//  LogTicketViewModel.swift
//  Staqo
//
//  Created by SHAILY on 01/04/21.
//

import Foundation
class LogTicketViewModel: ViewModelType {
   
    
   
    var delegate: ViewModelDelegate?
    private let dataSource:LogTicketDataSourceDelegate?
    init(dataSource: LogTicketDataSourceDelegate) {
        self.dataSource = dataSource
    }
    
    func bootstrap() {
        
    }
}
