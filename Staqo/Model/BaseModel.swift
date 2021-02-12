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
    
    
    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
       
    }
    init() {
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        }

    }
