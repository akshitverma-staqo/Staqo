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
    case roomData
    case notificationData
    case readNotification(email: String)
    case addNotification(ID:String,notifyID:String, email:String, flag:String)
    case dashboardMeneData
    case roomType
    case roomLocation
    case profile
    case roomArrangment
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

extension ResourceType:TargetType {
    var baseURL: URL {

        switch self {
//        case .downloadQR(_):
//            return URL(string: Configuration.ftpURL)!
        case.roomData , .readNotification(_),.addNotification(_,_,_,_),.roomLocation,.roomType,.roomArrangment:
            return URL(string: Configuration.ftpURL)!
        default:
            return URL(string:Configuration.baseURL)!
        }
    }
    
    var path: String {
        switch self {
        case .getEmployeeDataWithID(let emailID):
            return  Constant.kSiteID + Constant.kEMPLOYEE_FOR_ID + emailID + "'"
        case .download(let fileName):
            return  Constant.kDownloadPath + fileName
        
        case .updateByEmpID(_, let ID):
            return Constant.kSiteID + Constant.kEMPLOYEE_FIND_BY_ID + ID + "/fields"
        case .getTextReader(_):
            return Constant.kTest_Reader
        case .roomData:
            return Constant.kGET_ROOM
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
        case .roomArrangment:
            return Constant.kAllArrangementType
        }
        
    }

    var method: Moya.Method {
        switch self {
        case .getEmployeeDataWithID(_),.download(_),.roomData,.notificationData,.readNotification(_),.roomType,.roomLocation,.dashboardMeneData,.profile,.roomArrangment:
            return Moya.Method.get
        case .updateByEmpID(_,_):
            return Moya.Method.patch
        case .getTextReader(_),.addNotification(_,_,_,_):
            return Moya.Method.post
        
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .updateByEmpID(let mobileNo , _):
            return ["mobileno2":mobileNo]
        case .addNotification(let ID, let notifyID, let email, let flag):
            return ["id":ID , "notificationid": notifyID , "employeeemail":email , "rflag": flag]
            
        default:
            return nil
        }
    }
    
    var para: String?{
        switch self {
        case .getTextReader(let value):
            return value
        default:
            return nil
        }
    }
    
  
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getEmployeeDataWithID(_),.roomData,.notificationData,.readNotification(_),.dashboardMeneData,.roomType,.roomLocation,.profile,.roomArrangment:
            return .requestPlain
        case .download(_):
            return .downloadDestination(downloadDestination)
        case .updateByEmpID(_,_),.addNotification(_,_,_,_):
            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
            
        case .getTextReader(_):
            let data = Data(para!.utf8)
            return .requestData(data)
        
        }
    }
    
    var headers: [String : String]? {
        var httpHeaders: [String: String] = [:]
        switch self {
        case .getTextReader(_):
        httpHeaders["Ocp-Apim-Subscription-Key"] = "70ff304a4f9e40bbbf949ab8d06e1ce4"
        httpHeaders["Content-Type"] = "application/json"
            return httpHeaders
            
        case .roomData,.addNotification(_,_,_,_),.readNotification(_),.dashboardMeneData,.roomType,.roomLocation,.roomArrangment:
        httpHeaders["Accesstoken"] = "Bearer " + UserDefaults.standard.getAccessToken()
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

