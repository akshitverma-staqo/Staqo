//
//  Categories.swift
//  Staqo
//
//  Created by SHAILY on 07/04/21.
//

import Foundation
struct Categories : Codable {
	var deleted : Bool?
    var change_manager : String?
    var name : String?
    var description : String?
    var technician : String?
    var id : String?

	enum CodingKeys: String, CodingKey {

		case deleted = "deleted"
		case change_manager = "change_manager"
		case name = "name"
		case description = "description"
		case technician = "technician"
		case id = "id"
	}
    init() {
        
    }
    init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
		change_manager = try values.decodeIfPresent(String.self, forKey: .change_manager)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		technician = try values.decodeIfPresent(String.self, forKey: .technician)
		id = try values.decodeIfPresent(String.self, forKey: .id)
	}

}
