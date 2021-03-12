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
    case  updateByEmpID(mobileNo:String, ID:String)
    case download(fileName: String)

    
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
        }
    }

    var method: Moya.Method {
        switch self {
        case .getEmployeeDataWithID(_),.download(_):
            return Moya.Method.get
        case .updateByEmpID(_,_):
            return Moya.Method.patch
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .updateByEmpID(let mobileNo , _):
            return ["mobileno2":mobileNo]
        
        default:
            return nil
        }
    }
    
    var para: String?{
        switch self {
        default:
            return nil
        }
    }
    
  
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getEmployeeDataWithID(_):
            return .requestPlain
        case .download(_):
            return .downloadDestination(downloadDestination)
        case .updateByEmpID(_,_):
            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
            
        }
    }
    
    var headers: [String : String]? {
        var httpHeaders: [String: String] = [:]
        switch self {

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

