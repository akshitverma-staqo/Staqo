//
//  MSGraphData.swift
//  Staqo
//
//  Created by SHAILY on 09/03/21.
//

import Foundation
struct MSGraphData : Codable {
    var email : String?
    var name : String?
    var mobileNo1 : String?
    var jobDesignation:String?
    var businessPhone:String?
    
    
    enum CodingKeys: String, CodingKey {

        case email = "email"
        case name = "name"
        case mobileNo1 = "mobileNo1"
        case jobDesignation = "jobDesignation"
        case businessPhone = "businessPhones"
    }
    init(email:String , name:String , mobileNo1:String , jobDesignation:String, businessPhone:String) {
        self.email = email
        self.name = name
        self.mobileNo1 = mobileNo1
        self.jobDesignation = jobDesignation
        self.businessPhone = businessPhone
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        mobileNo1 = try values.decodeIfPresent(String.self, forKey: .mobileNo1)
        jobDesignation = try values.decodeIfPresent(String.self, forKey: .jobDesignation)
        businessPhone = try values.decodeIfPresent(String.self, forKey: .businessPhone)
        
        }

    }
