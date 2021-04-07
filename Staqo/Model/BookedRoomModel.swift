//
//  BookedRoomModel.swift
//  Staqo
//
//  Created by SHAILY on 03/04/21.
//


import Foundation
struct BookedRoomModel : Codable,Equatable {
    let bookingId : Int?
    let roomId : Int?
    let attendents : Int?
    let fromDateTime : String?
    let toDateTime : String?
    let roomStatus : String?
    let remarks : String?
    let visitorType : String?
    let roomType : String?
    let arrangementType : String?
    let notificationId : String?
    let roomCode : String?
    let recurringDay : String?
    let bookedBy : String?
    let approvedBy : String?
    let approvedDate : String?
    let createdOn : String?
    let modifiedOn : String?

    enum CodingKeys: String, CodingKey {

        case bookingId = "bookingId"
        case roomId = "roomId"
        case attendents = "attendents"
        case fromDateTime = "fromDateTime"
        case toDateTime = "toDateTime"
        case roomStatus = "roomStatus"
        case remarks = "remarks"
        case visitorType = "visitorType"
        case roomType = "roomType"
        case arrangementType = "arrangementType"
        case notificationId = "notificationId"
        case roomCode = "roomCode"
        case recurringDay = "recurringDay"
        case bookedBy = "bookedBy"
        case approvedBy = "approvedBy"
        case approvedDate = "approvedDate"
        case createdOn = "createdOn"
        case modifiedOn = "modifiedOn"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingId = try values.decodeIfPresent(Int.self, forKey: .bookingId)
        roomId = try values.decodeIfPresent(Int.self, forKey: .roomId)
        attendents = try values.decodeIfPresent(Int.self, forKey: .attendents)
        fromDateTime = try values.decodeIfPresent(String.self, forKey: .fromDateTime)
        toDateTime = try values.decodeIfPresent(String.self, forKey: .toDateTime)
        roomStatus = try values.decodeIfPresent(String.self, forKey: .roomStatus)
        remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
        visitorType = try values.decodeIfPresent(String.self, forKey: .visitorType)
        roomType = try values.decodeIfPresent(String.self, forKey: .roomType)
        arrangementType = try values.decodeIfPresent(String.self, forKey: .arrangementType)
        notificationId = try values.decodeIfPresent(String.self, forKey: .notificationId)
        roomCode = try values.decodeIfPresent(String.self, forKey: .roomCode)
        recurringDay = try values.decodeIfPresent(String.self, forKey: .recurringDay)
        bookedBy = try values.decodeIfPresent(String.self, forKey: .bookedBy)
        approvedBy = try values.decodeIfPresent(String.self, forKey: .approvedBy)
        approvedDate = try values.decodeIfPresent(String.self, forKey: .approvedDate)
        createdOn = try values.decodeIfPresent(String.self, forKey: .createdOn)
        modifiedOn = try values.decodeIfPresent(String.self, forKey: .modifiedOn)
    }
}
