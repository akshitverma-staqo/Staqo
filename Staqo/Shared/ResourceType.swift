//
//  ResourceType.swift
//  
//
//  Created by apple on 27/03/19.
//  Copyright © 2019 ESoft Technologies. All rights reserved.
//

import Foundation
import Moya

enum ResourceType {
    
    case getEmployeeDataWithID(emailID: String)
    case updateByEmpID(mobileNo:String, ID:String)
    case getTextReader(value:String)
    case download(fileName: String)
    case roomData(ID:String)
    case notificationData(email:String)
    case readNotification(email: String)
    case addNotification(ID:String,notifyID:String, email:String, flag:String)
    case dashboardMeneData
    case roomType
    case roomLocation
    case profile
    case roomArrangment(ID:String)
    case searchRoom(value :String)
    case getVisiterListData(ID: String)
    case bookedRoom
    case bookRoom(roomId: Int, attendents: Int, fromDateTime: String, toDateTime: String, roomStatus: String, purpose: String, visitorType: String, roomType: String, arrangementType: String, notificationId: String, roomCode: String, recurringDay: String, bookedBy: String, roomfeatures: String, roomtypeid: String)
    case getCatData
    case getTicket
    case getSubCatData(ID:String)
    case submitTicketData(desc: String, subj: String, catID: String, prioName: String, subID: String, email_ID:String, projName:String)
    case ticketImageUpload(file: String, ID:String, fileName:String)
    case approveCancel(bookingId: Int, roomStatus: String, approvedBy: String, userType: String,cancelBy: String, cancelRemark: String)
    case insertEmpData(email:String , orgID:Int, name:String , fcmToken:String , desig:String,mobileNo:String)
    case roomImages(url:String)
    case getCompanyData
    case fcmUpdate(ID:String, fcmID:String)
    var localLocation: URL? {

        switch self {
        case .download(let fileName):
            let directory = FileSystem.downloadDirectory
            let filePath = directory.appendingPathComponent(fileName)
            return filePath
//        case .downloadQR(let path):
//            let url = URL(string: path)
//            let directory = FileSystem.downloadDirectory
//            let filePath = directory.appendingPathComponent(url?.lastPathComponent ?? "")
//            return filePath
            
        default:
            return nil
        }
    }

    var downloadDestination: DownloadDestination {
       return { _, _ in return (self.localLocation!, [.removePreviousFile, .createIntermediateDirectories]) }
    }
}
//enum ResourceAlmoFire {
//    case getEmployeeDataWithID(emailID: String)
//}



extension ResourceType:TargetType {
    var baseURL: URL {

        switch self {
        case .download(_):
            return URL(string: Configuration.authURL)!
        case.roomData(_) , .readNotification(_),.addNotification(_,_,_,_),.roomLocation,.roomType,.roomArrangment(_),.dashboardMeneData,.searchRoom(_),.bookedRoom,.bookRoom(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_),.getCatData,.getCompanyData,.getTicket,.getSubCatData(_),.submitTicketData(_,_,_,_,_,_,_),.ticketImageUpload(_,_,_),.approveCancel(_,_,_,_,_,_),.notificationData(_),.fcmUpdate(_,_):
            return URL(string: Configuration.ftpURL)!
        case .getTextReader(_):
            return URL(string: Configuration.BNSUrl)!
        case .roomImages(let url):
        return URL(string: url)!
        default:
            return URL(string:Configuration.baseURL)!
        }
    }
    
    var path: String {
        switch self {
        case .getEmployeeDataWithID(let emailID):
            return  Constant.kSiteID + Constant.kEMPLOYEE_FOR_ID + emailID + "'"
        case .download(_):
            return  Constant.kDownloadPath
        
        case .updateByEmpID(_, let ID):
            print(Constant.kSiteID + Constant.kEMPLOYEE_FIND_BY_ID + ID + "/fields")
            return Constant.kSiteID + Constant.kEMPLOYEE_FIND_BY_ID + ID + "/fields"
        case .getTextReader(_):
            return Constant.kBusinessData2
        case .roomData(_):
            return Constant.kGET_ROOM
        case .notificationData(let email):
            return Constant.kGetAllNotification + email
        case .readNotification(let email):
            return   Constant.kNotificationRead + email
            
        case .addNotification(_,_,_,_):
            return  Constant.kAddNotification
            
        case .dashboardMeneData:
            return Constant.kGetDashboardData + "/" + (UserDefaults.standard.getProfile()?.email ?? "")
    
        case .roomType:
            return Constant.kAllRoomType
        case .roomLocation:
            return Constant.kAllLocationMaster
        case .profile:
            return Constant.kSiteID + Constant.kUSER_PIC_FROMAD
        case .roomArrangment(let ID):
            return Constant.kAllArrangementType + "/" + ID
        case .searchRoom(_):
        return Constant.kSearchBooking
        case .getVisiterListData(let ID):
            return  Constant.kSiteID + Constant.kVISITOR_LIST + ID + Constant.kVisiterList1
        case .bookedRoom:
            if UserDefaults.standard.getWebStatus() == "A" {
                print("Admin")
                return Constant.kBookingAdmin
            }else{

                print("User")
                return Constant.kViewBookedRoom
            }
            //return Constant.kViewBookedRoom
        case .bookRoom(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_):
        return Constant.kFreeRoomBooking
        case .getCompanyData:
            return Constant.kProjectApi
        case .getCatData:
            return Constant.kHelpCategory
        case .getTicket:
        return Constant.kHelpViewTicket
        case .getSubCatData(let ID):
            return Constant.kHelpSubCat1 + ID + Constant.kHelpSubCat2
        case .submitTicketData(_,_,_,_,_,_,_):
            return Constant.kHelpSubmitReq
        case .ticketImageUpload(_,_,_):
            return "/api/helpdesk/attachment"
        case .approveCancel(_, _, _, _, _,_):
            return Constant.kUpdateRoomStatus
        case .insertEmpData:
            return Constant.kSiteID + Constant.kEMPLOYEE_REGISTER
            
        case .roomImages(_):
            return ""
        case .fcmUpdate(_,_):
            return Constant.kupdatefcmidAPI
        }
        
        
    }

    var method: Moya.Method {
        switch self {
        case .getEmployeeDataWithID(_),.notificationData(_),.readNotification(_),.roomType,.roomLocation,.dashboardMeneData,.profile,.roomArrangment(_),.getVisiterListData(_),.bookedRoom,.getCatData,.getCompanyData,.getTicket,.getSubCatData(_):
            return Moya.Method.get
        case .updateByEmpID(_,_):
            return Moya.Method.patch
        case .getTextReader(_),.addNotification(_,_,_,_),.searchRoom(_),.bookRoom(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_),.submitTicketData(_,_,_,_,_,_,_),.ticketImageUpload(_,_,_),.approveCancel(_, _, _, _, _,_),.insertEmpData(_,_,_,_,_,_),.roomData(_),.fcmUpdate(_,_):
            return Moya.Method.post
        
        case .download(_),.roomImages(_):
            return Moya.Method.get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .updateByEmpID(let mobileNo , _):
            return ["mobileno2":mobileNo]
        case .addNotification(let ID, let notifyID, let email, let flag):
            return ["id":ID , "notificationid": notifyID , "employeeemail":email , "rflag": flag]
       
        case .bookRoom(let roomId, let attendents, let fromDateTime, let toDateTime, let roomStatus, let purpose, let visitorType, let roomType, let arrangementType, let notificationId, let roomCode, let recurringDay, let bookedBy, let roomfeatures, let roomtypeid):
            return ["roomId": roomId, "attendents": attendents,"fromDateTime": fromDateTime,"toDateTime": toDateTime,"roomStatus": roomStatus,"purpose": purpose,"visitorType": visitorType,"roomType": roomType,"arrangementType": arrangementType,"notificationId": notificationId,"roomCode": roomCode,"recurringDay": recurringDay,"bookedBy": bookedBy,"roomfeatures":roomfeatures, "roomtypeid":roomtypeid]
            
        case .ticketImageUpload(let file, let ID, let fileName):
            return ["filedata":file , "request_id":ID, "filename":fileName]
           // viewModel.submitTicketData(desc: desc, subj: subj, catID: catID, prioName: prioName, subID: subID, email_ID: email_ID, projName: projName)
        case .submitTicketData(let desc, let sub, let catID, let prioName, let subID, let email_ID,  let projName):
           
            return ["description": desc, "subject": sub, "category_id": catID, "priority":prioName, "subcategory_id":subID, "email_id": email_ID,  "project":projName]
            
           // desc: desc, subj: subj, catID: catID, prioName: prioName, subID: subID, email_ID: email_ID, projName: projName
            
        case .approveCancel(let bookingId,let roomStatus,let approvedBy,let userType,let cancelBy,let cancelRemark):
            return ["bookingId":bookingId, "roomStatus":roomStatus, "approvedBy":approvedBy, "userType":userType, "cancelBy":cancelBy,"cancelRemark":cancelRemark]
        case .insertEmpData(let email, let orgID, let name, let fcmToken, let desig, let mobileNo):
            return
                ["fields": ["Title":"oqtest@staqo.com","organizationidLookupId":"5","name":"Vishnu","ipaddress":"","designation":"hello","department":"IT","emailid":"oqtest@staqo.com","mobileno1":"9911933243"]]
            //["fields":["Title":email,"organizationidLookupId":orgID,"name":name,"ipaddress":fcmToken,"designation":desig,"department":"IT","emailid":email,"mobileno1":mobileNo]]
        case .getTextReader(let value):
            return  ["documents" : [
                ["language":"","id":"5","text":value]
]
]
            
        case .roomData(let ID):
            return ["locationid":ID]
            
        case .fcmUpdate(let ID ,let fcmID):
        return ["emailid":ID , "fcmid":fcmID]
        default:
            return nil
        }
    }
   
    
    var para: String?{
        switch self {
//        case .getTextReader(let value):
//            return value
        case.searchRoom(let value):
            return value
//        case .download(let fileName):
//            return fileName
//        case .submitTicketData(let Value):
//            return Value
//
        default:
            return nil
        }
    }
    
  
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getEmployeeDataWithID(_),.notificationData(_),.readNotification(_),.dashboardMeneData,.roomType,.roomLocation,.profile,.roomArrangment(_),.getVisiterListData(_),.bookedRoom,.getCatData,.getCompanyData,.getTicket,.getSubCatData(_):
            return .requestPlain
        case .download(_),.roomImages(_):
            return .requestPlain
        case .updateByEmpID(_,_),.addNotification(_,_,_,_),.bookRoom(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_),.approveCancel(_,_,_,_,_,_),.getTextReader(_),.roomData(_),.submitTicketData(_,_,_,_,_,_,_),.ticketImageUpload(_,_,_),.fcmUpdate(_,_):
            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
//        case .getTextReader(_):
//            let data = Data(para!.utf8)
//            return .requestData(data)
        case .searchRoom(_):
            let data = Data(para!.utf8)
            return .requestData(data)
//        case .submitTicketData(_):
//            let data = Data(para!.utf8)
//            return .requestData(data)
            
//        case .ticketImageUpload(let file, ):
//            let uploadFile = MultipartFormData(provider: .data(file), name: "file", fileName: "file.jpeg", mimeType: "image/jpeg")
//            print(file)
//            print(uploadFile)
//           // let requestID = MultipartFormData(provider: .data("\(ID)".data(using: String.Encoding.utf8) ?? Data()), name: "request_id")
//            return .uploadMultipart([uploadFile])
        case .insertEmpData(_,_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.prettyPrinted)
//        case .bookRoom(_):
//            let data = Data(para!.utf8)
//            return .requestData(data)
        }
        
    }
    
    var headers: [String : String]? {
        var httpHeaders: [String: String] = [:]
        switch self {
        case .getTextReader(_):
        httpHeaders["Ocp-Apim-Subscription-Key"] = "70ff304a4f9e40bbbf949ab8d06e1ce4"
        httpHeaders["Content-Type"] = "application/json"
            return httpHeaders
            
        case .roomData(_),.addNotification(_,_,_,_),.readNotification(_),.dashboardMeneData,.roomType,.roomLocation,.roomArrangment(_),.searchRoom(_),.bookedRoom,.bookRoom(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_),.getTicket,.getCompanyData,.getCatData,.getSubCatData(_),.submitTicketData(_,_,_,_,_,_,_),.approveCancel(_,_,_,_,_,_),.ticketImageUpload(_,_,_),.notificationData(_),.fcmUpdate(_,_):
        httpHeaders["Accesstoken"] = "Bearer " + UserDefaults.standard.getAccessToken()
     // httpHeaders["TechnicianKey"] = "D3DE8EE6-B6AE-49C8-98ED-C93D308CB33F"
        httpHeaders["Content-Type"] = "application/json"
        return httpHeaders
        case .download(_):
            httpHeaders["Authorization"] = "Bearer " + UserDefaults.standard.getAccessToken()
           // httpHeaders["Content-Type"] = "application/json"
            return httpHeaders
//        case .ticketImageUpload(_,_):
//            httpHeaders["Accesstoken"] = "Bearer " + UserDefaults.standard.getAccessToken()
//            httpHeaders["TechnicianKey"] = "D3DE8EE6-B6AE-49C8-98ED-C93D308CB33F"
//            //httpHeaders["Content-type" ] = "application/json"
//            return httpHeaders
        default:
        
       httpHeaders["Authorization"] = "Bearer " + UserDefaults.standard.getAccessToken()
       httpHeaders["Content-Type"] = "application/json"
         return httpHeaders
        
        }
    }
    
}


class FileSystem {
    
    static let documentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()
    
    static let cacheDirectory: URL = {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()
    
    static let downloadDirectory: URL = {
        let directory: URL = FileSystem.documentsDirectory.appendingPathComponent("Download/")
        print("DOWNLOAD FOLDER:==== \(directory)")
        return directory
    }()
    
    static func isFileAvailable(fileName: String) -> Bool {
        let path = FileSystem.downloadDirectory.appendingPathComponent(fileName).path
        return FileManager.default.fileExists(atPath: path)
    }
}

