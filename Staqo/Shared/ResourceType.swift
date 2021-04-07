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
    case notificationData
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
    case bookRoom(roomId: Int, attendents: Int, fromDateTime: String, toDateTime: String, roomStatus: String, purpose: String, visitorType: String, roomType: String, arrangementType: String, notificationId: String, roomCode: String, recurringDay: String, bookedBy: String)
    
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
        case.roomData(_) , .readNotification(_),.addNotification(_,_,_,_),.roomLocation,.roomType,.roomArrangment(_),.dashboardMeneData,.searchRoom(_),.bookedRoom,.bookRoom(_,_,_,_,_,_,_,_,_,_,_,_,_):
            return URL(string: Configuration.ftpURL)!
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
            return Constant.kSiteID + Constant.kEMPLOYEE_FIND_BY_ID + ID + "/fields"
        case .getTextReader(_):
            return Constant.kTest_Reader
        case .roomData(let ID):
            return Constant.kGET_ROOM + ID
        case .notificationData:
            return Constant.kSiteID + Constant.kGetAllNotification
        case .readNotification(let email):
            return   Constant.kNotificationRead + email
            
        case .addNotification(_,_,_,_):
            return  Constant.kAddNotification
            
        case .dashboardMeneData:
            return Constant.kGetDashboardData
    
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
            //return Constant.kViewBookedRoom + (UserDefaults.standard.getProfile()?.email ?? "") + "/list"
            //return "http://182.73.254.13/oq/api​/booking​/oqtest1@staqo.com/list"
            return Constant.kViewBookedRoom
        case .bookRoom(_,_,_,_,_,_,_,_,_,_,_,_,_):
        return Constant.kFreeRoomBooking
        }
        
        
    }

    var method: Moya.Method {
        switch self {
        case .getEmployeeDataWithID(_),.download(_),.roomData(_),.notificationData,.readNotification(_),.roomType,.roomLocation,.dashboardMeneData,.profile,.roomArrangment(_),.getVisiterListData(_),.bookedRoom:
            return Moya.Method.get
        case .updateByEmpID(_,_):
            return Moya.Method.patch
        case .getTextReader(_),.addNotification(_,_,_,_),.searchRoom(_),.bookRoom(_,_,_,_,_,_,_,_,_,_,_,_,_):
            return Moya.Method.post
        
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .updateByEmpID(let mobileNo , _):
            return ["mobileno2":mobileNo]
        case .addNotification(let ID, let notifyID, let email, let flag):
            return ["id":ID , "notificationid": notifyID , "employeeemail":email , "rflag": flag]
       
        case .bookRoom(let roomId, let attendents, let fromDateTime, let toDateTime, let roomStatus, let purpose, let visitorType, let roomType, let arrangementType, let notificationId, let roomCode, let recurringDay, let bookedBy):
        return ["roomId": roomId, "attendents": attendents,"fromDateTime": fromDateTime,"toDateTime": toDateTime,"roomStatus": roomStatus,"purpose": purpose,"visitorType": visitorType,"roomType": roomType,"arrangementType": arrangementType,"notificationId": notificationId,"roomCode": roomCode,"recurringDay": recurringDay,"bookedBy": bookedBy]
        
        default:
            return nil
        }
    }
   
    
    var para: String?{
        switch self {
        case .getTextReader(let value):
            return value
        case.searchRoom(let value):
            return value
        case .download(let fileName):
            return fileName
        default:
            return nil
        }
    }
    
  
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getEmployeeDataWithID(_),.roomData(_),.notificationData,.readNotification(_),.dashboardMeneData,.roomType,.roomLocation,.profile,.roomArrangment(_),.getVisiterListData(_),.bookedRoom:
            return .requestPlain
        case .download(_):
            return .downloadDestination(downloadDestination)
        case .updateByEmpID(_,_),.addNotification(_,_,_,_),.bookRoom(_,_,_,_,_,_,_,_,_,_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
        case .getTextReader(_):
            let data = Data(para!.utf8)
            return .requestData(data)
        case .searchRoom(_):
            let data = Data(para!.utf8)
            return .requestData(data)
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
            
        case .roomData(_),.addNotification(_,_,_,_),.readNotification(_),.dashboardMeneData,.roomType,.roomLocation,.roomArrangment(_),.searchRoom(_),.bookedRoom,.bookRoom(_):
        httpHeaders["Accesstoken"] = "Bearer " + UserDefaults.standard.getAccessToken()
        httpHeaders["Content-Type"] = "application/json"
        return httpHeaders
        case .download(_):
            httpHeaders["Authorization"] = "Bearer " + UserDefaults.standard.getAccessToken()
            httpHeaders["Content-Type"] = "application/json"
            return httpHeaders
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

