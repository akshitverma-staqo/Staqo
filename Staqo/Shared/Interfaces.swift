//
//  Interfaces.swift
//  
//
//  Created by apple on 27/03/19.
//  Copyright © 2019 ESoft Technologies. All rights reserved.
//

import Foundation
import UIKit

protocol DataSourceType {
   // func fetchByMoya(completion:@escaping(Result<BaseModel>)->Void)
}

protocol ViewModelDelegate:class {
    func willLoadData()
    func didLoadData()
    func didFail(error:CustomError)
}

protocol ViewModelType {
    func bootstrap()
    var delegate:ViewModelDelegate? {get set}
}
