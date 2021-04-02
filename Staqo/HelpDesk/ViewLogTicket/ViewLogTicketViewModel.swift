//
//  ViewLogTicketViewModel.swift
//  Staqo
//
//  Created by SHAILY on 01/04/21.
//

import Foundation

class ViewLogTicketViewModel: ViewModelType {
   
    
   
    var delegate: ViewModelDelegate?
    private let dataSource:ViewLogTicketDataSourceDelegate?
    init(dataSource: ViewLogTicketDataSourceDelegate) {
        self.dataSource = dataSource
    }
    
    func bootstrap() {
        
    }
}
