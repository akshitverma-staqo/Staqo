//
//  BaseModel.swift
//  GrocerApp
//
//  Created by apple on 27/03/19.
//  Copyright © 2019 ESoft Technologies. All rights reserved.
//

import Foundation

struct BaseModel : Codable {
    var status : String?
    var message : String?
    var data : String?
    var value : [Value]?
    var fieldsData: Fields?
    
    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "@odata.context"
        case value = "value"
        case fieldsData = "fields"
    }
    init() {
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(String.self, forKey: .data)
        value = try values.decodeIfPresent([Value].self, forKey: .value)
        fieldsData = try values.decodeIfPresent(Fields.self, forKey: .fieldsData)
        
        }

    }
