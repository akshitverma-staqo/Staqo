//
//  ReadNotify.swift
//  Staqo
//
//  Created by SHAILY on 31/03/21.
//


import Foundation
struct ReadNotify : Codable {
    var id : String?
    var notificationid : String?
    var title : String?
    var description: String?
    var date : String?
    var displayDate: String?
    var employeeemail : String?
    var rflag : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case notificationid = "notificationid"
        case employeeemail = "employeeemail"
        case title = "title"
        case description = "description"
        case date = "date"
        case displayDate = "displayDate"
        case rflag = "rflag"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        notificationid = try values.decodeIfPresent(String.self, forKey: .notificationid)
        employeeemail = try values.decodeIfPresent(String.self, forKey: .employeeemail)
        rflag = try values.decodeIfPresent(Int.self, forKey: .rflag)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        displayDate = try values.decodeIfPresent(String.self, forKey: .displayDate)
        date = try values.decodeIfPresent(String.self, forKey: .date)

        
    }

}
