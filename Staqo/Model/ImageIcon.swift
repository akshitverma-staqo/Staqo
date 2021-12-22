//
//  ImageIcon.swift
//  Staqo
//
//  Created by SHAILY on 21/04/21.
//

import Foundation
struct ImageIcon : Codable {
    let type : String?
    let fileName : String?
    
    let fieldName : String?
    let serverUrl : String?
    let serverRelativeUrl : String?
    let id : String?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case fileName = "fileName"
       
        case fieldName = "fieldName"
        case serverUrl = "serverUrl"
        case serverRelativeUrl = "serverRelativeUrl"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        fileName = try values.decodeIfPresent(String.self, forKey: .fileName)
       
        fieldName = try values.decodeIfPresent(String.self, forKey: .fieldName)
        serverUrl = try values.decodeIfPresent(String.self, forKey: .serverUrl)
        serverRelativeUrl = try values.decodeIfPresent(String.self, forKey: .serverRelativeUrl)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}
