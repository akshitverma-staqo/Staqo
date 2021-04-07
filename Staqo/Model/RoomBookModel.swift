//
//  RoomBookModel.swift
//  Staqo
//
//  Created by SHAILY on 06/04/21.
//


import Foundation
struct RoomBookModel : Codable {
    var roomId : Int?
    var attendents : Int?
    var fromDateTime : String?
    var toDateTime : String?
    var roomStatus : String?
    var purpose : String?
    var visitorType : String?
    var roomType : String?
    var arrangementType : String?
    var notificationId : String?
    var roomCode : String?
    var recurringDay : String?
    var bookedBy : String?


    enum CodingKeys: String, CodingKey {

        case roomId = "roomId"
        case attendents = "attendents"
        case fromDateTime = "fromDateTime"
        case toDateTime = "toDateTime"
        case roomStatus = "roomStatus"
        case purpose = "purpose"
        case visitorType = "visitorType"
        case roomType = "roomType"
        case arrangementType = "arrangementType"
        case notificationId = "notificationId"
        case roomCode = "roomCode"
        case recurringDay = "recurringDay"
        case bookedBy = "bookedBy"
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
        purpose = try values.decodeIfPresent(String.self, forKey: .purpose)
        visitorType = try values.decodeIfPresent(String.self, forKey: .visitorType)
        roomType = try values.decodeIfPresent(String.self, forKey: .roomType)
        arrangementType = try values.decodeIfPresent(String.self, forKey: .arrangementType)
        notificationId = try values.decodeIfPresent(String.self, forKey: .notificationId)
        roomCode = try values.decodeIfPresent(String.self, forKey: .roomCode)
        recurringDay = try values.decodeIfPresent(String.self, forKey: .recurringDay)
        bookedBy = try values.decodeIfPresent(String.self, forKey: .bookedBy)
    }

}
