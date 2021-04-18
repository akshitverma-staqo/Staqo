//
//  FreeRoomModel.swift
//  Staqo
//
//  Created by SHAILY on 03/04/21.
//

import Foundation
struct FreeRoomModel : Codable,Equatable {
    let id : Int?
    let title : String?
    let roomCode : String?
    let name : String?
    let floor : Double?
    let capacity : Double?
    let status : String?
    let sequenceNumber : Int?
    let webUrl:String?
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case roomCode = "roomCode"
        case name = "name"
        case floor = "floor"
        case capacity = "capacity"
        case status = "status"
        case sequenceNumber = "sequenceNumber"
        case webUrl = "webUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        roomCode = try values.decodeIfPresent(String.self, forKey: .roomCode)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        floor = try values.decodeIfPresent(Double.self, forKey: .floor)
        capacity = try values.decodeIfPresent(Double.self, forKey: .capacity)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        sequenceNumber = try values.decodeIfPresent(Int.self, forKey: .sequenceNumber)
        webUrl = try values.decodeIfPresent(String.self, forKey: .webUrl)
    }
    

}