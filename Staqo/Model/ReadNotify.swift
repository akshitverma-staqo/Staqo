//
//  ReadNotify.swift
//  Staqo
//
//  Created by SHAILY on 31/03/21.
//


import Foundation
struct ReadNotify : Codable {
    var id : Int?
    var notificationid : String?
    var employeeemail : String?
    var rflag : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case notificationid = "notificationid"
        case employeeemail = "employeeemail"
        case rflag = "rflag"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        notificationid = try values.decodeIfPresent(String.self, forKey: .notificationid)
        employeeemail = try values.decodeIfPresent(String.self, forKey: .employeeemail)
        rflag = try values.decodeIfPresent(Int.self, forKey: .rflag)
    }

}
