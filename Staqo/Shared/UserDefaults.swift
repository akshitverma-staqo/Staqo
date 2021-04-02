//
//  UserDefaults.swift
//
//
//  Created by Esoft on 15/10/19.
//  Copyright © 2019 Esoft. All rights reserved.
//

import Foundation

import MSGraphClientModels
import MSAL
import MSGraphClientSDK
enum UserDefaultsKeys : String {
    case isLoggedIn
    case userID
    case userName
    case emailID
    case profileData
    case currentAddress
    case accessToken
    case menuStatus
}


extension UserDefaults {
    
    //UserDefaults.standard.string(forKey: "tokenResult1") ?? ""
    //// MARK:- : -  Check Login
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        //synchronize()
    }
    
    func isLoggedIn()-> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    func setAccessToken(value: String) {
        return set(value, forKey: UserDefaultsKeys.accessToken.rawValue)
    }
    
    func getAccessToken() -> String{
        return value(forKey: UserDefaultsKeys.accessToken.rawValue) as! String
    }
    
    
   
    
    
    func setUserID(value: String){
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
        //synchronize()
    }
 
    
    func setMenuStatus() -> Bool {
        return bool(forKey: UserDefaultsKeys.menuStatus.rawValue)
    }
    
    func setMenuValue(value:Bool){
        set(value, forKey: UserDefaultsKeys.menuStatus.rawValue)
        
    }
    
    
    
    //// MARK:- : -  Retrieve User Data
    func getUserID() -> String{
        return value(forKey: UserDefaultsKeys.userID.rawValue) as! String
    }
    
    func setEmailID(value: String) {
        set(value, forKey: UserDefaultsKeys.emailID.rawValue)
    }
    
    func getEmail() -> String {
        return value(forKey: UserDefaultsKeys.emailID.rawValue) as! String
    }
    
    func setUserName(value: String) {
        set(value, forKey: UserDefaultsKeys.userName.rawValue)
    }
    
    func setProfile(value:MSGraphData?)  {
        set(try? PropertyListEncoder().encode(value), forKey: UserDefaultsKeys.profileData.rawValue)
    }
    
    func setCurrentAddress(value:String?){
        set(value, forKey: UserDefaultsKeys.currentAddress.rawValue)
    }
    
    func getCurrentAddress() -> String {
        return value(forKey: UserDefaultsKeys.currentAddress.rawValue) as? String ?? ""
    }
    
    func getProfile() -> MSGraphData? {
            if let obj = data(forKey: UserDefaultsKeys.profileData.rawValue){
                       let value = try? PropertyListDecoder().decode(MSGraphData.self, from: obj)
                       return value
                   }
            return nil
    }
  
    func getUserName() -> String {
        return value(forKey: UserDefaultsKeys.userName.rawValue) as? String ?? ""
    }
   
    
    func reset() {
        removeObject(forKey: UserDefaultsKeys.userID.rawValue)
        removeObject(forKey: UserDefaultsKeys.userName.rawValue)
        removeObject(forKey: UserDefaultsKeys.emailID.rawValue)
        set(false, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}
