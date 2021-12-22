//
//  RoomType.swift
//  Staqo
//
//  Created by SHAILY on 31/03/21.
//

import Foundation
struct RoomType : Codable {
    let id : Int?
    let title : String?
    let typeName : String?
    let status : String?
    let sequenceNumber : Double?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case typeName = "typeName"
        case status = "status"
        case sequenceNumber = "sequenceNumber"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        typeName = try values.decodeIfPresent(String.self, forKey: .typeName)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        sequenceNumber = try values.decodeIfPresent(Double.self, forKey: .sequenceNumber)
    }

}
