//
//  MazzayakomCatURLModel.swift
//  Staqo
//
//  Created by SHAILY on 30/05/21.
//



import Foundation
struct MazzayakomCatURLModel {
    var Url : String = ""

   
    init(){
        
    }

    init(json:JSON) {
        //let values = try decoder.container(keyedBy: CodingKeys.self)
        Url = json["Url"].stringValue
    }

}
