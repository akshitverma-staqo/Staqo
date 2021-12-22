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
    
    //static let kSiteID = "347d2bb7-7c8d-4d31-8d34-783763ab8ccb"
    
   // static let kNOTIFICATION_URL = "/lists/Notifications/items?$expand=fields"
    
    static let kVISITOR_LIST = "/lists/Visitor%20Master/items/?$expand=fields&$filter=fields/employeeidLookupId%20eq%20'"
    static let kVisiterList1 = "'%20or%20fields/scanby%20eq%20'1'%20"
    static let kVISITOR_REGISTER = "/lists/Visitor%20Master/items"
    static let kSALMEEN_POINT1 = "https://thisisoq.sharepoint.com/Pages/Salmeen.aspx"
    static let kSALMEEN_POINT2 = "https://oq.com/en/covid-19/declaration-employees"
    static let kOqRoadshow = "https://dx.oq.com"
    static let kUSER_PIC_FROMAD = "https://graph.microsoft.com/v1.0/users/**useremail**/photo/$value"
    static let kEMPLOYEE_FOR_ID = "/lists/Employee%20Master/items/?$expand=fields&$filter=fields/emailid%20eq%20'"
    static let kEMPLOYEE_FIND_BY_ID = "/lists/Employee%20Master/items/"
    static let kEMPLOYEE_REGISTER =  "/lists/Employee Master/items"
    static let kMAZZAYAKOM_SUB_CATEGORY_URL =  "/lists/Corporate_Offers/items/?$expand=fields&$filter=fields/CategoryLookupId%20eq%20'"
    static let kVISITOR_DUPLICATE =  "/lists/Visitor%20Master/items?$expand=fields&$filter=fields/emailid%20eq%20'"
    static let kVISITOR_DUPLICATE1 = "'%20and%20fields/scanby%20eq%20'1'%20"
    
    
    //Live Credentials
    //static let kOQPORTAL_LINK = URL(string:"https://thisisoq.sharepoint.com")
    static let OQPORTAL_LINK = "https://thisisoq.sharepoint.com"
    
    static let kMAZZAYACOM_LINK =  "/lists/**OC_LIST_ID**/items?expand=fields"
    static let kMAZZAYACOM_SUB_LINK =  "/lists/**C_list_id**/items?expand=fields(select=CategoryLookupId,Title,Caption)&$filter=fields/CategoryLookupId%20eq%20'"
    static let kMAZZAYACOM_IMAGE_LINK = "/drives/**Assests_ID**/root:/lists/**A_list_ID**/"
    
    //Local
    //static let kSiteID = "544d5eca-671c-4f65-9dbe-7d4b50b02b9c"
   //Live
    static let kSiteID = "347d2bb7-7c8d-4d31-8d34-783763ab8ccb"
    //static let kSiteID = "f2187b05-698b-4a40-91f6-440903c570af"

    
    
    
    //                UserDefaults.standard.set(SITE_ID, forKey: "SITE_ID")
    //
    //                let MAZZAYACOM_C_LIST_ID =  "a9aa5be4-4b8d-487d-ae72-839a1de9ba13"
    //                UserDefaults.standard.set(MAZZAYACOM_C_LIST_ID, forKey: "MAZZAYACOM_C_LIST_ID")
    //
    //                let MAZZAYACOM_ASSET_ID =  "b!yl5NVBxnZU-dvn1LULArnLdQ9qy4h6RMivIbCnyeHmVmO87f0Pt3SaG3WIEXWwfC"
    //                UserDefaults.standard.set(MAZZAYACOM_ASSET_ID, forKey: "MAZZAYACOM_ASSET_ID")
    //
    //                let MAZZAYACOM_C_SITE_ID = "544d5eca-671c-4f65-9dbe-7d4b50b02b9c"
    //                UserDefaults.standard.set(MAZZAYACOM_C_SITE_ID, forKey: "MAZZAYACOM_C_SITE_ID")
    
    //                let MAZZAYACOM_A_LIST_ID = "2fecd167-6659-4906-b8cc-8d06047056de"
    //                UserDefaults.standard.set(MAZZAYACOM_A_LIST_ID, forKey: "MAZZAYACOM_A_LIST_ID")
    //
    
    //  Live
    static let kMAZZAYACOM_C_SITE_ID = "9267b16d-b59f-4aaa-998c-c81bdea24279"
    static let kMAZZAYACOM_C_LIST_ID =  "35eec527-6587-458c-a35f-dd06e8e79487"
    static let kMAZZAYACOM_ASSET_ID =  "b!bbFnkp-1qkqZjMgb3qJCeTz4E1V1WUFLoF8xgKa1gCLpyFwaggbeRIZdZ0UUm0sz"
    //static let kSITE_ID = "347d2bb7-7c8d-4d31-8d34-783763ab8ccb"
    
    //MARK:-HelpDesk
    static let kHelpCategory = "/api/helpdesk/categories"
    static let kHelpSubCat1 = "/api/helpdesk/"
    static let kHelpSubCat2 = "/subcategories"
    static let kHelpSubmitReq = "api/helpdesk/request" ///api/helpdesk/request" //Post to submit
    static let kHelpViewTicket = "/api/helpdesk/" + (UserDefaults.standard.getProfile()?.email)! + "/request" // Get to view Ticket
    static let kHelpAttach1 = "/api/helpdesk/"
    static let kHelpAttach2 = "/attachment"
    static let kProjectApi = "/api/helpdesk/project"

 
    
    //Room API
    static let kGET_ROOM = "/api/roombyid"//"/api/room/"
    static let kAllRoomType = "/api/getAllRoomType"
    static let kAllRoomFeature = "/api/getAllRoomFeature"
    static let kAllRoomAuthority = "/api/getAllRoomAuthority"
    static let kAllAuthorityMaster = "/api/getAllAuthorityMaster"
    static let kAllLocationMaster = "/api/getAllLocationMaster"
    static let kAllArrangementType = "/api/arrangementtype"
    static let kSearchBooking = "/api/searchbooking"
    
    //user 
    static let kViewBookedRoom = "/api/booking/" + (UserDefaults.standard.getProfile()?.email)! + "/list"//api​/booking​/{email_id}​/list
    static let kFreeRoomBooking = "/api/booking"
    static let kUpdateRoomStatus = "/api/booking/updatestatus"
    
    
    //Admin Level API
    static let kBookingAdmin = "/api/booking/admin/\((UserDefaults.standard.getProfile()?.email)!)"
    
    
   
    
    //Notification read unread
    static let kGetAllNotification = "api/notification/"// "/lists/Notifications/items?$expand=fields"
    static let kNotificationRead = "/api/notification/findByEmail/"
    static let kAddNotification = "/api/notification/add"
    
    //Dashboard API
    static let kGetDashboardData = "/api/getAllMenuMaster"
    
    //Businesscard data scan api
    static let kBusinessData2 = "text/analytics/v3.0/entities/recognition/general"
    
    
    
    static let kLoginAuth = "customer/SendOTP"
    static let kDownloadPath = "/me/photo/$value"
    
    // MARK:-   StoryBoard
    static let kMainStoryboard = "Main"
    static let kHomeStoryboard = "Home"
    static let kBusinessStoryboard = "Business"
    static let kRoomStroyboard = "Room"
    static let kNotification = "Notification"
    static let kHDStroyboard = "HelpDesk"
    static let kMazzaykomStoryboard = "Mazzaykom"
    
    
    // MARK:- View Controllers
    static let kDashboardNavigationVC = "DashboardNavigationVC  "
    
    static let kLoginVC = "LoginVC"
    static let kHomeVC = "HomeVC"
    static let kWebViewVC = "WebViewVC"
    static let kEmpVC = "EmpVC"
    static let kBusinessVC = "BusinessVC"
    static let kBusinessCardVC = "BusinessCardVC"
    static let kVisitorListVC = "VisitorListVC"
    static let kScanQRViewController = "ScanQRViewController"
    static let kRoomBookingVC = "RoomBookingVC"
    static let kMenuVC = "MenuVC"
    static let kAboutUsController = "AboutUsController"
    static let kContactViewController = "ContactViewController"
    static let kFAQViewController = "FAQViewController"
    static let kTermConditionViewController = "TermConditionViewController"
    static let kPrivacyViewController = "PrivacyViewController"
    static let kNotificationVC = "NotificationVC"
    static let kViewLogTicketVC = "ViewLogTicketVC"
    static let kLogTicketVC = "LogTicketVC"
    static let kHelpDeskVC = "HelpDeskVC"
    static let kTicketStatusVC = "TicketStatusVC"
    static let kBooKRoomVC = "BooKRoomVC"
    static let kRoomPhotoVC = "RoomPhotoVC"
    static let kRoomBookMainVC = "RoomBookMainVC"
    static let kApproveCancelVC = "ApproveCancelVC"
    static let kSalmeenVC = "SalmeenViewController"
    static let kSwipeControllerVC = "SwipeUpViewController"
    static let kMazzayakomViewControllerVC = "MazzayakomViewController"
    static let kVisitingCardDataVC = "VisitingCardData"
    static let kupdatefcmidAPI = "/api/updatefcmid"
    
    
    
    
    
    
    
    //MARK:- WebView URL
    static let kOQPORTAL_LINK = "https://thisisoq.sharepoint.com"
    //static let kOQPORTAL_LINK1 = "signnow-private-cloud://sso_login?refresh_token=" + UserDefaults.standard.getAccessToken() + "&access_token=" + UserDefaults.standard.getAccessToken() + "&hostname=//esign.oq.com"
    
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
    static func stringToDate(format:String , dateValue:String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    let resultDate = formatter.date(from: dateValue)
    return resultDate
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
        //2021-04-20T05:49:32.802+00:00
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
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
  //  formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        formatter.dateFormat = "dd-MM-yyyy"
        
        if let date =  formatter.date(from: strDate) {
            let viewFormatter = DateFormatter()
            //viewFormatter.dateFormat = "dd,MMM - h:mm a"
            viewFormatter.dateFormat = "dd-MM"
            
            return viewFormatter.string(from: date)
        }
        return "-"
    }
    
    static func formatModifiedTime(strDate: String?) -> String {
        
        guard let strDate = strDate else { return "-"}
        
        let formatter = DateFormatter()
        //2019-05-03 12:11:15
        
        formatter.timeZone = TimeZone.current
//    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        formatter.dateFormat = "HH:mm:ss"
        
        if let date =  formatter.date(from: strDate) {
            let viewFormatter = DateFormatter()
            //viewFormatter.dateFormat = "dd,MMM - h:mm a"
            viewFormatter.dateFormat = "HH:mm"
            
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

    static func isValidWenUrl(url:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
            let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
            let result = urlTest.evaluate(with: url)
            return result
    }
    
}

