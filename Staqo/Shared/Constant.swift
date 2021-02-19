//
//  Constant.swift
//  
//
//  Created by Esoft on 15/10/19.
//  Copyright © 2019 Esoft. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    
    // Webservices Path
    static let kBaseUrl = "https://jsonplaceholder.typicode.com/"
    
    static let kDomain = "com.staqo"
    static let kRootPath = "api/"
    
    
    static let kLoginAuth = "customer/SendOTP"
    static let kDownloadPath = "downloadFile/"
    
        // MARK:-   StoryBoard
        static let kMainStoryboard = "Main"
        static let kHomeStoryboard = "Home"
  
    
    // MARK:- View Controllers
    static let kDashboardNavigationVC = "DashboardNavigationVC"
    
    static let kLoginVC = "LoginVC"
    static let kHomeVC = "HomeVC"
    
    
    // MARK:-  Popup View
    
    
    // MARK:-  Alert Title
    static let kAlertTitle_LOGOUT = "LOGOUT"
    static let kAlertTitle_MESSAGE = "MESSAGE"
    static let kAlertTitle_ERROR = "ERROR"
    static let kAlertTitle_NOFORMS = "NO FORMS"
    static let kAlertTitle_WARNING =  "WARNING"
    static let kAppName = " App"
    // MARK:-  Alert Action
    static let kAlertAction_YES = "YES"
    static let kAlertAction_CANCEL = "CANCEL"
    static let kAlertAction_NO = "NO"
    
    // MARK:-  Image
    
    
    // MARK:-  Hex
    static let kColor_TabSelection = "#FD6876"
    static let kHex_TabSelection = "#FD6876"
    static let kNavGreen = "NavGreen"
    static let kAddiDocBtn = "AddiDocBtn"
    static let kTextColor = "TextColor"
    static let kIndicator = "Indicator"
    static let kPreCheckTitle = "PreCheckTitle"
    static let kSelectedText = "SelectedText"
    static let kCellColor = "cellColor"
    
    
    // MARK:- Date Time Format
    static let dd_MMM_yyyy = "dd-MMM-yyyy"
    static let hh_mm_a = "hh:mm a"
    static let dd_MM_yyyy = "dd-MM-yyyy"
    static let dd_MM_yyyy_Time = "dd-MMM-yyyy hh:mm a"
    static let yyyy_MM_dd = "yyyy-MM-dd HH:mm:ss +zzzz"
    
    //MARK:- Price Format
    static let kRupeesUnicode = "\u{20B9}"
    
    
    static func getViewController<T: UIViewController>(storyboard: String, identifier: String, type: T.Type) -> T {
        return Constant.getViewController(storyboard: storyboard, identifier: identifier) as! T
    }
    
    static func getViewController(storyboard: String, identifier: String) -> UIViewController {
        let storyboard = Constant.storyboard(storyboardID: storyboard)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    private static func storyboard(storyboardID: String) -> UIStoryboard {
        let storyboard = UIStoryboard(name: storyboardID, bundle: Bundle.main)
        return storyboard
    }
    
    
    static func getCell<T: UITableViewCell>(cell: UITableViewCell, type: T.Type) -> T {
        return  cell as! T
    }
    
    
    static func getImage(fileName: String?) -> UIImage! {
        
        guard let file = fileName else { return UIImage(named: "Profile-25x25") }
        _ = URL(string: file)
        //        if let image =  UIImage(contentsOfFile: FileSystem.downloadDirectory.appendingPathComponent(file).path) {
        //            return image
        //        }
        
        if let image =  UIImage(contentsOfFile: file) {
            return image
        }
        
        return UIImage(named: "Profile-25x25")
    }
    
//    static func setImage(from url: String) -> UIImage! {
//        guard let imageURL = URL(string: url) else { return UIImage(named: "Profile-25x25")}
//        var image:UIImage?
//        // just not to cause a deadlock in UI!
//        
//        guard let imageData = try? Data(from: imageURL as! Decoder) else { return UIImage(named: "Profile-25x25")}
//        image = UIImage(data: imageData)
//        
//        
//        return image
//    }
    
    static func dateTimeFormatter(format: String, date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let resultDate = formatter.string(from: date)
        return resultDate
        
        /*let calendar = Calendar.current
         let day = calendar.component(.day, from: date)
         let month = calendar.component(.month, from: date)
         let year = calendar.component(.year, from: date)
         return String(format: "%02d/%02d/%d", day,month, year)*/
    }
    static func dateTimeDateFormatter(format:String , date:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let resultDate = formatter.string(for: date)
       // let resultDate = formatter.date(from: date)
        return resultDate ?? "-"
    }
    static func getTimeFromDate(date: Date) -> String {
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return String(format: "%02d:%02d", hour,minutes)
    }
    
    static func formatDate(strDate: String?) -> String {
        
        guard let strDate = strDate else { return "-"}
        
        let formatter = DateFormatter()
        //2019-05-03 12:11:15
        //   formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.s"
        
        if let date =  formatter.date(from: strDate) {
            let viewFormatter = DateFormatter()
            viewFormatter.dateFormat = "dd-MMM-yyyy hh:mm a"
            
            return viewFormatter.string(from: date)
        }
        return "-"
    }
    static func formatModifiedDate(strDate: String?) -> String {
        
        guard let strDate = strDate else { return "-"}
        
        let formatter = DateFormatter()
        //2019-05-03 12:11:15
       
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        //formatter.dateFormat = "YYYY-MM-DDThh:mm:ss.sssssss"
        
        if let date =  formatter.date(from: strDate) {
            let viewFormatter = DateFormatter()
            viewFormatter.dateFormat = "MMMM dd, yyyy"
            
            return viewFormatter.string(from: date)
        }
        return "-"
    }
    
//    static func getTotalHours(dateFormat: String,dateToConvert:String) -> String {
//
//        let dateFormatter = DateFormatter()
//        /*  dateFormatter.dateFormat = dateFormat
//         let convertDate = dateFormatter.date(from: dateToConvert)
//
//
//         let strToday = dateFormatter.string(from: Date())
//         let TodayDate = dateFormatter.date(from:strToday)!
//
//         print(convertDate!.offset(from:TodayDate))
//         return convertDate!.offset(from: TodayDate)*/
//
//        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
//        let convertedDate = dateFormatter.date(from: dateToConvert)
//        dateFormatter.timeZone = TimeZone(identifier: "UTC")
//        let str = dateFormatter.string(from: convertedDate!)
//        let convertedDateNew = dateFormatter.date(from: str)
//
//        print(Date().offset(from: convertedDate!))
//        return Date().offset(from: convertedDate!)
//    }
    
    static func dateToString(date: Date) -> String {
        
        let formatter = DateFormatter()
        //2019-05-03 12:11:15
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
    
    static func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    static func addBarButton() -> UIBarButtonItem{
        let logoutBtn = UIButton(type: .custom)
        logoutBtn.setImage(UIImage(named: "logout"), for: .normal)
        logoutBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //   logoutBtn.addTarget(self, action: #selector(Constant.logoutBtnTapped), for: .touchUpInside)
        let item = UIBarButtonItem(customView: logoutBtn)
        return item
    }
    
//    @objc func logoutBtnTapped(){
//        let loginVC = Constant.getViewController(storyboard: Constant.kMainStoryboard, identifier: Constant.kLoginVC, type: LoginVC.self)   //self.storyboard?.instantiateViewController(withIdentifier: Constant.kLoginVC) as! LoginVC
//        UserDefaults.standard.setLoggedIn(value: false)
//        let navController = UINavigationController(rootViewController: loginVC)
//        navController.isNavigationBarHidden = true
//        let appDel = UIApplication.shared.delegate as! AppDelegate
//        appDel.window?.rootViewController = navController
//    }
//
    static func gererateCode(cnt: Int?, code: String?) -> String?  {
        
        return nil
    }
    
    
    static func addCartValue(value:Int)-> Int{
        var count:Int = value
        count = count + 1
        return count
    }
    static func removeCartValue(value:Int)-> Int{
        var count:Int = value
        count = count - 1
        return count
    }
    
}

