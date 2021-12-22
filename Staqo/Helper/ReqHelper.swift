//
//  ReqHelper.swift
//  Staqo
//
//  Created by SHAILY on 09/04/21.
//

import Foundation
struct ReqHelper : Codable {
    var request : Request?
    var helpdesk_request : Helpdesk_request?
    
    enum CodingKeys: String, CodingKey {
        
        case request = "request"
        case helpdesk_request = "helpdesk_request"
    }
    init() {
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        request = try values.decodeIfPresent(Request.self, forKey: .request)
        helpdesk_request = try values.decodeIfPresent(Helpdesk_request.self, forKey: .helpdesk_request)
    }

}
