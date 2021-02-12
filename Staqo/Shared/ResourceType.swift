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
    case validateUser(mobileNo: String)
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
        case .validateUser(_):
            return Constant.kRootPath + Constant.kLoginAuth
        case .download(let fileName):
            return  Constant.kDownloadPath + fileName
       
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .validateUser(_):
            return Moya.Method.post
        case .download(_):
            return Moya.Method.get
       
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .validateUser(let mobileNo):
            return ["iMobNo":mobileNo]
        
        default:
            return nil
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .validateUser(_):
            return  .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
        case .download(_):
            return .downloadDestination(downloadDestination)
        }
    }
    
    var headers: [String : String]? {
        var httpHeaders: [String: String] = [:]
        switch self {

        default:
    //   httpHeaders["Authorization"] = UserDefaults.standard.getUserToken()
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

