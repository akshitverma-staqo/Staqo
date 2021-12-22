//
//  RoomSearchModel.swift
//  Staqo
//
//  Created by SHAILY on 03/04/21.
//

import Foundation
struct RoomSearchModel : Codable {
    var locID:Int?
    var roomId : Int?
    var attendents : Int?
    var fromDateTime : String?
    var toDateTime : String?
    var roomStatus : String?
    var remarks : String?
    var visitorType : String?
    var roomType : String?
    var arrangementType : String?
    var roomCode : String?
    var notificationId : String?
    var recurringDay : String?
    var bookedBy : String?

    enum CodingKeys: String, CodingKey {

        case roomId = "roomId"
        case attendents = "attendents"
        case fromDateTime = "fromDateTime"
        case toDateTime = "toDateTime"
        case roomStatus = "roomStatus"
        case remarks = "remarks"
        case visitorType = "visitorType"
        case roomType = "roomType"
        case arrangementType = "arrangementType"
        case roomCode = "roomCode"
        case notificationId = "notificationId"
        case recurringDay = "recurringDay"
        case bookedBy = "bookedBy"
        case locID = "locationid"
    }
    init() {
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        roomId = try values.decodeIfPresent(Int.self, forKey: .roomId)
        attendents = try values.decodeIfPresent(Int.self, forKey: .attendents)
        fromDateTime = try values.decodeIfPresent(String.self, forKey: .fromDateTime)
        toDateTime = try values.decodeIfPresent(String.self, forKey: .toDateTime)
        roomStatus = try values.decodeIfPresent(String.self, forKey: .roomStatus)
        remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
        visitorType = try values.decodeIfPresent(String.self, forKey: .visitorType)
        roomType = try values.decodeIfPresent(String.self, forKey: .roomType)
        arrangementType = try values.decodeIfPresent(String.self, forKey: .arrangementType)
        roomCode = try values.decodeIfPresent(String.self, forKey: .roomCode)
        notificationId = try values.decodeIfPresent(String.self, forKey: .notificationId)
        recurringDay = try values.decodeIfPresent(String.self, forKey: .recurringDay)
        bookedBy = try values.decodeIfPresent(String.self, forKey: .bookedBy)
        locID = try values.decodeIfPresent(Int.self, forKey: .locID)
    }

}
