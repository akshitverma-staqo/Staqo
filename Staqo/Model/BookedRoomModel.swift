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
    let fromDate : String?
    let fromTime : String?
    let toDate : String?
    let toTime : String?
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
    let roomfeatures : String?
    let roomtypeid : String?
    let rday : String?

    enum CodingKeys: String, CodingKey {

        case bookingId = "bookingId"
        case roomId = "roomId"
        case attendents = "attendents"
        case fromDate = "fromDate"
        case fromTime = "fromTime"
        case toDate = "toDate"
        case toTime = "toTime"
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
        case roomfeatures = "roomfeatures"
        case roomtypeid = "roomtypeid"
        case rday = "rday"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingId = try values.decodeIfPresent(Int.self, forKey: .bookingId)
        roomId = try values.decodeIfPresent(Int.self, forKey: .roomId)
        attendents = try values.decodeIfPresent(Int.self, forKey: .attendents)
        fromDate = try values.decodeIfPresent(String.self, forKey: .fromDate)
        fromTime = try values.decodeIfPresent(String.self, forKey: .fromTime)
        toDate = try values.decodeIfPresent(String.self, forKey: .toDate)
        toTime = try values.decodeIfPresent(String.self, forKey: .toTime)
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
        roomfeatures = try values.decodeIfPresent(String.self, forKey: .roomfeatures)
        roomtypeid = try values.decodeIfPresent(String.self, forKey: .roomtypeid)
        rday = try values.decodeIfPresent(String.self, forKey: .rday)
    }

}
