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
    case userName
    case emailID
    case profileData
    case accessToken
    case menuStatus
    case webStatus
    case adminStatus
    case notifyCount
    case empID
    case FCMToken
    case profileImage
}


extension UserDefaults {
    
    //UserDefaults.standard.string(forKey: "tokenResult1") ?? ""
    
    func setProfileImage(value:Data)  {
        
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(value) {
        print(encodedUser)
            set(encodedUser ,forKey: UserDefaultsKeys.profileImage.rawValue)
        }
       
    }
    func getProfileImage() -> Data? {
        var valueData:Data? = nil
        let data = value(forKey: UserDefaultsKeys.profileImage.rawValue)
        if let decoded = try? JSONDecoder().decode(Data.self, from: data as? Data ?? Data()) {
                   valueData = decoded
                    return valueData
                }
        return valueData
    }
    func setnotifyCount(value:Int){
        return set(value , forKey: UserDefaultsKeys.notifyCount.rawValue)
    }
    func setAccessToken(value: String) {
        return set(value, forKey: UserDefaultsKeys.accessToken.rawValue)
    }
    
    func getAccessToken() -> String{
        return value(forKey: UserDefaultsKeys.accessToken.rawValue) as! String
    }
    
    func setEmpID(value:String) {
        set(value , forKey: UserDefaultsKeys.empID.rawValue)
    }
    func getEmpID() ->String{
        return value(forKey: UserDefaultsKeys.empID.rawValue) as! String
    }
    func setWebStatus(value:String){
        return set(value, forKey: UserDefaultsKeys.webStatus.rawValue)
    }
    
    func getWebStatus() -> String {
        return value(forKey: UserDefaultsKeys.webStatus.rawValue) as! String
    }
    
    func setFCMToken(value:String) {
        return set(value, forKey: UserDefaultsKeys.FCMToken.rawValue)
    }
    func getFCMToken() -> String {
        return value(forKey: UserDefaultsKeys.FCMToken.rawValue) as! String
    }
    
    func setAdminStatus(value: String) {
        return set(value, forKey: UserDefaultsKeys.adminStatus.rawValue)
        
    }
    func getNotifyCount() -> Int {
        return value(forKey: UserDefaultsKeys.notifyCount.rawValue) as? Int ?? 0
    }
    
    func getAdminStatus() -> String {
        return value(forKey: UserDefaultsKeys.adminStatus.rawValue) as! String
    }
 
    
    func setMenuStatus() -> Bool {
        return bool(forKey: UserDefaultsKeys.menuStatus.rawValue)
    }
    
    func setMenuValue(value:Bool){
        set(value, forKey: UserDefaultsKeys.menuStatus.rawValue)
        
    }
    
    
    
    
    
    //// MARK:- : -  Retrieve User Data
   
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
        removeObject(forKey: UserDefaultsKeys.userName.rawValue)
        removeObject(forKey: UserDefaultsKeys.emailID.rawValue)
    }
}
