//
//  Site.swift
//  Staqo
//
//  Created by SHAILY on 08/04/21.
//

import Foundation
struct Site : Codable {
    let id : String?
    let name : String?


    enum CodingKeys: String, CodingKey {

        case name = "name"
      
        case id = "id"
    
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        id = try values.decodeIfPresent(String.self, forKey: .id)
     
    }

}
