//
//  HomeViewModal.swift
//  Staqo
//
//  Created by SHAILY on 18/02/21.
//

import Foundation
class HomeViewModal:ViewModelType{
   
//    var imageArr:Array<String>?
//    var curveArr:Array<String>?
//    var TopLabArray:Array<String>?
    var rows : [(imageArr:[String], curveArr:[String], TopLabArray:[String])]?
    private let dataSource: HomeDataSourceDelegate?
    var delegate: ViewModelDelegate?
    init(dataSource: HomeDataSourceDelegate) {
        self.dataSource = dataSource
    }
    func bootstrap() {
        
    }
    func scrollImage(){
//        imageArr = ["set1.png","set2.png","salmeenicon.png","bcimage.png"]
//        curveArr = ["blob1.png","blob2.png","blob1.png","blob2.png"]
//        TopLabArray = ["OQ Portal","Mazzayacom","Salmeen","Business Card"]
        rows?.append((["set1.png","set2.png","salmeenicon.png","bcimage.png"],["blob1.png","blob2.png","blob1.png","blob2.png"],["OQ Portal","Mazzayacom","Salmeen","Business Card"]))
        delegate?.didLoadData()
    }
    
}
