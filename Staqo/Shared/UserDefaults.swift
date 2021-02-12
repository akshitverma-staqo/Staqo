//
//  UserDefaults.swift
//
//
//  Created by Esoft on 15/10/19.
//  Copyright © 2019 Esoft. All rights reserved.
//

import Foundation


enum UserDefaultsKeys : String {
    case isLoggedIn
    case userID
    case userName
    case emailID
    case userToken
    case profileImage
    case imageUrl
    case user
    case role
    case employee
    case rights
    case loginUser
    case password
    case isOnboardIn
    case cartBadge
    case deviceToken
    case profileData
    case currentAddress
}


extension UserDefaults {
    
    
    //// MARK:- : -  Check Login
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        //synchronize()
    }
    
    func isLoggedIn()-> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    //MARK:- check on board
    func setOnboardIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isOnboardIn.rawValue)
        //synchronize()
    }
    
    func isOnboardIn()-> Bool {
           return bool(forKey: UserDefaultsKeys.isOnboardIn.rawValue)
       }
    //// MARK:- : -  Save User Data
    func setUserToken(value: String){
        set(value, forKey: UserDefaultsKeys.userToken.rawValue)
        //synchronize()
    }
    
    func setUserID(value: Int){
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
        //synchronize()
    }
    //// MARK:-  Save the profile image
    
    func setProfileImage(value: String) {
         set(value, forKey: UserDefaultsKeys.profileImage.rawValue)
    }
    
    func setImageUrl(value:String){
        set(value, forKey: UserDefaultsKeys.imageUrl.rawValue)
    }
    
    //// MARK:- : -  Retrieve User Data
    func getUserID() -> Int{
        return value(forKey: UserDefaultsKeys.userID.rawValue) as! Int
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
  
    func setLoginUser(value:String?){
        set(value, forKey: UserDefaultsKeys.loginUser.rawValue)
    }
    func setPassword(value:String?) {
        set(value, forKey: UserDefaultsKeys.password.rawValue)
    }
    func setCartBadge(value:String?) {
        set(value, forKey: UserDefaultsKeys.cartBadge.rawValue)
    }
    
    func setDeviceToken(value:String?){
        set(value, forKey: UserDefaultsKeys.deviceToken.rawValue)
    }
    
//    func setProfile(value:ProfileData?)  {
//        set(try? PropertyListEncoder().encode(value), forKey: UserDefaultsKeys.profileData.rawValue)
//    }
    func setCurrentAddress(value:String?){
        set(value, forKey: UserDefaultsKeys.currentAddress.rawValue)
    }
    
    func getCurrentAddress() -> String {
        return value(forKey: UserDefaultsKeys.currentAddress.rawValue) as? String ?? ""
    }
//        func getProfile() -> ProfileData? {
//            if let obj = data(forKey: UserDefaultsKeys.profileData.rawValue)  {
//              let value = try? PropertyListDecoder().decode(ProfileData.self, from: obj)
//                return value
//            }
//            return nil
//        }
    
    func getDeviceToken() -> String {
        return value(forKey: UserDefaultsKeys.deviceToken.rawValue) as? String ?? ""
    }
    
    
    func getUserName() -> String {
        return value(forKey: UserDefaultsKeys.userName.rawValue) as! String
    }
    func getUserToken() -> String {
        return value(forKey: UserDefaultsKeys.userToken.rawValue) as? String ?? ""
    }
    
    func getProfileImage() -> String {
        return value(forKey: UserDefaultsKeys.profileImage.rawValue) as! String
    }
    
    func getImageUrl() -> String {
        return value(forKey: UserDefaultsKeys.imageUrl.rawValue) as? String ?? ""
    }
    
    func getCartBadge() -> String {
        return value(forKey: UserDefaultsKeys.cartBadge.rawValue) as? String ?? ""
    }

    
    func getLoginUser() -> String? {
           return value(forKey: UserDefaultsKeys.loginUser.rawValue) as? String
       }
    func getPassword() -> String? {
        return value(forKey: UserDefaultsKeys.password.rawValue) as? String
    }
    
    func reset() {
        removeObject(forKey: UserDefaultsKeys.userID.rawValue)
        removeObject(forKey: UserDefaultsKeys.userName.rawValue)
        removeObject(forKey: UserDefaultsKeys.emailID.rawValue)
        removeObject(forKey: UserDefaultsKeys.employee.rawValue)
        removeObject(forKey: UserDefaultsKeys.user.rawValue)
        
        set(false, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}
