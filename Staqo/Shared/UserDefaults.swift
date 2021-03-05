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
    case accessToken
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
    
    func setUserID(value: String){
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
    
//    func setProfile(value:MSGraphUser?)  {
//     
//        if (try? NSKeyedArchiver.archivedData(withRootObject: value as Any, requiringSecureCoding: false)) != nil {
//            
//           }
//        
//        
//        
//        
//    }
//    
    
    


    func setCurrentAddress(value:String?){
        set(value, forKey: UserDefaultsKeys.currentAddress.rawValue)
    }
    
    func getCurrentAddress() -> String {
        return value(forKey: UserDefaultsKeys.currentAddress.rawValue) as? String ?? ""
    }
//        func getProfile() -> MSGraphUser? {
//
//            if let decoded  = data(forKey: UserDefaultsKeys.profileData.rawValue){
//
//
//            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? MSGraphUser
//
//            return decodedTeams
//            }
//            return nil
//        }
    
    

    
    
    
    func getDeviceToken() -> String {
        return value(forKey: UserDefaultsKeys.deviceToken.rawValue) as? String ?? ""
    }
    
    
    func getUserName() -> String {
        return value(forKey: UserDefaultsKeys.userName.rawValue) as? String ?? ""
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
