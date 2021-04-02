//
//  Location.swift
//  Staqo
//
//  Created by SHAILY on 31/03/21.
//

import Foundation
struct Location : Codable {
    let id : Int?
    let title : String?
    let locationName : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case locationName = "locationName"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
