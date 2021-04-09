//
//  Technician.swift
//  Staqo
//
//  Created by SHAILY on 08/04/21.
//

import Foundation
struct Technician : Codable {
    let email_id : String?
    let phone : String?
    let name : String?
    let mobile : String?
    let is_vipuser : Bool?
    let id : String?
    let department : Department?

    enum CodingKeys: String, CodingKey {

        case email_id = "email_id"
        case phone = "phone"
        case name = "name"
        case mobile = "mobile"
        case is_vipuser = "is_vipuser"
        case id = "id"
        case department = "department"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email_id = try values.decodeIfPresent(String.self, forKey: .email_id)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        is_vipuser = try values.decodeIfPresent(Bool.self, forKey: .is_vipuser)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        department = try values.decodeIfPresent(Department.self, forKey: .department)
    }

}
