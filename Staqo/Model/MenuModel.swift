//
//  MenuModel.swift
//  Staqo
//
//  Created by SHAILY on 07/04/21.
//

import Foundation
struct MenuModel : Codable {
    var id : Int?
    var menutype : String?
    var title : String?
    var menuname : String?
    var menuurl : String?
    var parentid : Int?
    var status : String?
    var seqid : Double?
    var iconurl : String?
    var isSelected:Bool?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case menutype = "menutype"
        case title = "title"
        case menuname = "menuname"
        case menuurl = "menuurl"
        case parentid = "parentid"
        case status = "status"
        case seqid = "seqid"
        case iconurl = "iconurl"
        case isSelected = "isSelected"
    }
    init() {
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        menutype = try values.decodeIfPresent(String.self, forKey: .menutype)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        menuname = try values.decodeIfPresent(String.self, forKey: .menuname)
        menuurl = try values.decodeIfPresent(String.self, forKey: .menuurl)
        parentid = try values.decodeIfPresent(Int.self, forKey: .parentid)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        seqid = try values.decodeIfPresent(Double.self, forKey: .seqid)
        iconurl = try values.decodeIfPresent(String.self, forKey: .iconurl)
        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected)
    }

}
