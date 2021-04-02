//
//  Configuration.swift
//  CampBell
//
//  Created by apple on 27/03/19.
//  Copyright © 2019 ESoft Technologies. All rights reserved.
//

import Foundation

import Foundation

enum Environment: String {
    case dev = "DEV"
    case prod = "PROD"
}

struct Configuration {
    private static let environment: Environment = {
        
        guard let environmentString = Bundle.main.infoDictionary?["Environment"] as? String else {
             return .dev
        }
        //   XCGLogger.debug("Environment: \(environmentString)")
        return Environment(rawValue: environmentString) ?? .dev
    }()
    
    private static let environmentSettings: [String: String]? = {
        if let envPlistPath = Bundle.main.path(forResource: "EnvironmentList", ofType: "plist"),
            let envDict = NSDictionary(contentsOfFile: envPlistPath) {
            let envSettings = envDict[environment.rawValue] as? [String: String]
            return envSettings
        } else {
            assertionFailure("Environment.plist is not found!")
            return nil
        }
    }()
    
    static var getEnvironment: String {
        return environment.rawValue
    }
    
    static let baseURL: String = {
        guard let url = environmentSettings?["BaseURL"] else {
            assertionFailure("BaseURL is not set for environment: \(environment)!")
            return ""
        }
        return url
    }()
    
    
    
    static let authURL: String = {
        guard let url = environmentSettings?["AuthURL"] else {
            assertionFailure("AuthURL is not set for environment: \(environment)!")
            return ""
        }
        return url
    }()
    
    static let ftpURL: String = {
        guard let url = environmentSettings?["FTP_URL"] else {
            assertionFailure("FTP_URL is not set for environment: \(environment)!")
            return ""
        }
        return url
    }()
    
//    static let Users: String = {
//        guard let user = environmentSettings?["Users"] else {
//            assertionFailure("Users is not set for environment: \(environment)!")
//            return ""
//        }
//        return user
//    }()
}
