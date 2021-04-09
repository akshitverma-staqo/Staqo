//
//  Priority.swift
//  Staqo
//
//  Created by SHAILY on 09/04/21.
//

import Foundation
struct Priority : Codable {
    var color : String?
    var name : String?
    var id : String?

    
    enum CodingKeys: String, CodingKey {

        case color = "color"
        case name = "name"
        case id = "id"
    
    }
    init() {
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        
     
    }

}
