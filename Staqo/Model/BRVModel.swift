//
//  BRVModel.swift
//  Staqo
//
//  Created by SHAILY on 06/04/21.
//

import Foundation
struct BRVModel : Codable {
    let bookingId : Int?
    let roomId : Int?
    let attendents : Int?
    let fromDateTime : String?
    let toDateTime : String?
    let roomStatus : String?
    let purpose : String?
    let visitorType : String?
    let roomType : String?
    let arrangementType : String?
    let notificationId : String?
    let roomCode : String?
    let recurringDay : String?
    let bookedBy : String?
    let cancelBy : String?
    let cancelRemark : String?
    let cancelDateTime : String?
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
        case purpose = "purpose"
        case visitorType = "visitorType"
        case roomType = "roomType"
        case arrangementType = "arrangementType"
        case notificationId = "notificationId"
        case roomCode = "roomCode"
        case recurringDay = "recurringDay"
        case bookedBy = "bookedBy"
        case cancelBy = "cancelBy"
        case cancelRemark = "cancelRemark"
        case cancelDateTime = "cancelDateTime"
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
        purpose = try values.decodeIfPresent(String.self, forKey: .purpose)
        visitorType = try values.decodeIfPresent(String.self, forKey: .visitorType)
        roomType = try values.decodeIfPresent(String.self, forKey: .roomType)
        arrangementType = try values.decodeIfPresent(String.self, forKey: .arrangementType)
        notificationId = try values.decodeIfPresent(String.self, forKey: .notificationId)
        roomCode = try values.decodeIfPresent(String.self, forKey: .roomCode)
        recurringDay = try values.decodeIfPresent(String.self, forKey: .recurringDay)
        bookedBy = try values.decodeIfPresent(String.self, forKey: .bookedBy)
        cancelBy = try values.decodeIfPresent(String.self, forKey: .cancelBy)
        cancelRemark = try values.decodeIfPresent(String.self, forKey: .cancelRemark)
        cancelDateTime = try values.decodeIfPresent(String.self, forKey: .cancelDateTime)
        approvedBy = try values.decodeIfPresent(String.self, forKey: .approvedBy)
        approvedDate = try values.decodeIfPresent(String.self, forKey: .approvedDate)
        createdOn = try values.decodeIfPresent(String.self, forKey: .createdOn)
        modifiedOn = try values.decodeIfPresent(String.self, forKey: .modifiedOn)
    }

}
