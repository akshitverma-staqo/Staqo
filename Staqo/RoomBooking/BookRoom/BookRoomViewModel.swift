//
//  BookRoomViewModel.swift
//  Staqo
//
//  Created by SHAILY on 02/04/21.
//

import Foundation

class BookRoomViewModel: ViewModelType {
   
var delegate: ViewModelDelegate?
private let dataSource:BookRoomDataSourceDelegate?
init(dataSource: BookRoomDataSourceDelegate) {
    self.dataSource = dataSource
}

func bootstrap() {
    
}
}
