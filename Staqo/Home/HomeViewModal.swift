//
//  HomeViewModal.swift
//  Staqo
//
//  Created by SHAILY on 18/02/21.
//

import Foundation
class HomeViewModal:ViewModelType{
   

    var rows : (imageArr:[String], curveArr:[String], TopLabArray:[String])?
    private let dataSource: HomeDataSourceDelegate?
    var delegate: ViewModelDelegate?
    init(dataSource: HomeDataSourceDelegate) {
        self.dataSource = dataSource
    }
    func bootstrap() {
        self.scrollImage()
    }
    func scrollImage(){

        rows = (["set1.png","set2.png","salmeenicon.png","bcimage.png"],["blob1.png","blob2.png","blob1.png","blob2.png"],["OQ Portal","Mazzayacom","Salmeen","Business Card"])
        
        delegate?.didLoadData()
    }
    
}
