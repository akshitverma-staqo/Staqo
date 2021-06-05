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
    let capacity : Int?
    let status : String?
    let sequenceNumber : Int?
    let webUrl:String?
    let roomtype: String?
    let roomfeatures: String?
    let roomtypeid: String?
    let fdate: String?
    let ftime: String?
    let rday: String?
    
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
        case roomtype = "roomtype"
        case roomfeatures = "roomfeatures"
        case roomtypeid = "roomtypeid"
        case fdate = "fdate"
        case ftime = "ftime"
        case rday = "rday"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        roomCode = try values.decodeIfPresent(String.self, forKey: .roomCode)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        floor = try values.decodeIfPresent(Double.self, forKey: .floor)
        capacity = try values.decodeIfPresent(Int.self, forKey: .capacity)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        sequenceNumber = try values.decodeIfPresent(Int.self, forKey: .sequenceNumber)
        webUrl = try values.decodeIfPresent(String.self, forKey: .webUrl)
        roomtype = try values.decodeIfPresent(String.self, forKey: .roomtype)
        roomfeatures = try values.decodeIfPresent(String.self, forKey: .roomfeatures)
        roomtypeid = try values.decodeIfPresent(String.self, forKey: .roomtypeid)
        fdate = try values.decodeIfPresent(String.self, forKey: .fdate)
        ftime = try values.decodeIfPresent(String.self, forKey: .ftime)
        rday = try values.decodeIfPresent(String.self, forKey: .rday)



    }
    

}
