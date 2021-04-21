//
//  SelectedRoomOptionModel.swift
//  Staqo
//
//  Created by SHAILY on 03/04/21.
//

import Foundation
struct SelectedRoomOptionModel : Codable {
    let toDateTime : String?
    let remarks : String?
    let roomCode : String?
    let arrangementType : String?
    let recurringDay : String?
    let attendents : Int?
    let roomStatus : String?
    let roomType : String?
    let fromDateTime : String?
    let visitorType : String?
    let bookedBy : String?
    let roomtypeid: String?

    enum CodingKeys: String, CodingKey {

        case toDateTime = "toDateTime"
        case remarks = "remarks"
        case roomCode = "roomCode"
        case arrangementType = "arrangementType"
        case recurringDay = "recurringDay"
        case attendents = "attendents"
        case roomStatus = "roomStatus"
        case roomType = "roomType"
        case fromDateTime = "fromDateTime"
        case visitorType = "visitorType"
        case bookedBy = "bookedBy"
        case roomtypeid = "roomtypeid"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        toDateTime = try values.decodeIfPresent(String.self, forKey: .toDateTime)
        remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
        roomCode = try values.decodeIfPresent(String.self, forKey: .roomCode)
        arrangementType = try values.decodeIfPresent(String.self, forKey: .arrangementType)
        recurringDay = try values.decodeIfPresent(String.self, forKey: .recurringDay)
        attendents = try values.decodeIfPresent(Int.self, forKey: .attendents)
        roomStatus = try values.decodeIfPresent(String.self, forKey: .roomStatus)
        roomType = try values.decodeIfPresent(String.self, forKey: .roomType)
        fromDateTime = try values.decodeIfPresent(String.self, forKey: .fromDateTime)
        visitorType = try values.decodeIfPresent(String.self, forKey: .visitorType)
        bookedBy = try values.decodeIfPresent(String.self, forKey: .bookedBy)
        roomtypeid = try values.decodeIfPresent(String.self, forKey: .roomtypeid)

    }

}
