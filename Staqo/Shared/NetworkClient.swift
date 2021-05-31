//
//  NetworkClient.swift
//  
//
//  Created by apple on 27/03/19.
//  Copyright © 2019 ESoft Technologies. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum StaoqResult<T> {
    case success(T)
  //  case failure(Error)
  //  case customFailure(CustomError)
    case failure(CustomError)
}

enum DownloadResult {
    case progress(Double)
    case success(Data)
    case failure(CustomError)
}

class NetworkClient {
    
    static let provider = MoyaProvider<ResourceType>()
   
// Method using Moya
//    static func request<K:Codable>(target: ResourceType, success successCallBack: @escaping (Result<K>) -> Void, error errorCallBack: @escaping (Swift.Error) -> Void, failure failureCallBack: @escaping (Error) -> Void) {
//
//        provider.request(target) { (result) in
//
//            switch result {
//            case .success(let response):
//
//                if response.statusCode >= 200 && response.statusCode <= 300 {
//                    do {
//
//                        let strJson = String(data: response.data, encoding: .utf8)
//                        print("RESPONSE JSON: \(strJson ?? "NO JSON STRING")")
//
//                        let decoder = JSONDecoder()
//                        let object = try decoder.decode(K.self, from: response.data)
//                        let result: Result<K> = Result.success(object)
//                        successCallBack(result)
//                    }
//                    catch {
//                        //  completion(.failure(error))
//                        // completion(.Customfailure(CustomError.ParsingError))
//                        let error = NSError(domain: Constant.kDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Parsing Error"])
//                        errorCallBack(error)
//                    }
//                }
//                else {
//                    let error = NSError(domain: Constant.kDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Hey its 404"])
//                    errorCallBack(error)
//                }
//            case .failure(let error):
//                print("FAILED:  \(MoyaError.underlying(error, nil))")
//
//                switch error {
//                case .underlying(let err as NSError, _):
//                    print(err.code)
//                    print(err.domain)
//                    failureCallBack(err)
//                default:
//                    print("Commom Error")
//                }
//            }
//        }
//    }
    
    static func request(target: ResourceType, progress: ProgressBlock?, completion: @escaping (DownloadResult) -> Void) -> Cancellable {
        return provider.request(target, progress: progress) { result in
            switch result {
            case .success(let response):
            let data = response.data
            let strJson = String(data: data, encoding: .utf8)
            print("DOWNLOAD RESPONSE JSON: \(strJson ?? "NO JSON STRING")")
                completion(DownloadResult.success(data))
            case .failure(_):
                completion(.failure(CustomError.DownloadFailed))
            } 
        }
        
    }

//    static func request<K: Codable>(target: ResourceType, progress: ProgressBlock?, completion: @escaping (Result<K>) -> Void) -> Cancellable {
//        return provider.request(target, progress: progress) { result in
//            switch result {
//            case let .success(response):
//                do {
//                let data = response.data
//                let strJson = String(data: response.data, encoding: .utf8)
//                print("DOWNLOAD RESPONSE JSON: \(strJson ?? "NO JSON STRING")")
//                let decoder = JSONDecoder()
//                let object = try decoder.decode(K.self, from: data)
//
//                completion(Result.success(object))
//                }
//                catch {
//                    completion(.failure(CustomError.ParsingError))
//                }
//            case .failure(_):
//                completion(.failure(CustomError.DownloadFailed))
//            }
//        }
//    }
    static func requestAlmofire<K:Codable>(passToUrl url:String, passToMethod method:HTTPMethod, passToParameter parameter:Any?=nil, passToHeader header:HTTPHeaders? , success successCallBack: @escaping (StaoqResult<K>) -> Void,error errorCallBack: @escaping (CustomError) -> Void, failure failureCallBack: @escaping (CustomError) -> Void ){
        Alamofire.request(url, method: method, parameters:parameter as! [String: Any]?, encoding: JSONEncoding.prettyPrinted, headers: header).responseJSON { (responce) in
            switch responce.result {
            
            case .success(let data):
                do {
                    
                    let strJson = String(data:responce.data!, encoding: .utf8)
                    print("RESPONSE JSON: \(strJson ?? "NO JSON STRING")")
                    
                    
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(K.self, from: responce.data! )
                    let result: StaoqResult<K> = StaoqResult.success(object)
                    successCallBack(result)
                }
                catch (let error) {
                    print(error)
                    errorCallBack(CustomError.ParsingError)
                }
                
               
            case .failure(let error):
                print(error)
                failureCallBack(CustomError.HTTPError(err: error))
            }
        }
    }
    
    
    
    static func request<K:Codable>(target: ResourceType, success successCallBack: @escaping (StaoqResult<K>) -> Void, error errorCallBack: @escaping (CustomError) -> Void, failure failureCallBack: @escaping (CustomError) -> Void) {
        
        provider.request(target) { (result) in
            print("result ========== \(result)")
            switch result {
            case .success(let response):
                
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    do {
                        
                        let strJson = String(data: response.data, encoding: .utf8)
                        print("RESPONSE JSON: \(strJson ?? "NO JSON STRING")")
                        
                        
                        let decoder = JSONDecoder()
                        let object = try decoder.decode(K.self, from: response.data)
                        let result: StaoqResult<K> = StaoqResult.success(object)
                        successCallBack(result)
                    }
                    catch (let error) {
                        print(error)
                        errorCallBack(CustomError.ParsingError)
                    }
                }
                else if response.statusCode == 401{
                    do {
                        let strJson = String(data: response.data, encoding: .utf8)
                        print("RESPONSE JSON: \(strJson ?? "NO JSON STRING")")
                        let decoder = JSONDecoder()
                        let object = try decoder.decode(BaseModel.self, from: response.data)
                        let error = NSError(domain: Constant.kDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: object.error ?? "Unable to connect"])
                                errorCallBack(CustomError.HTTPError(err: error))
                        }
                    catch {
                    errorCallBack(CustomError.SessionExpired)
                    }
                }
                else if response.statusCode >= 400 && response.statusCode <= 499 {
                    do {
                        let strJson = String(data: response.data, encoding: .utf8)
                        print("RESPONSE JSON: \(strJson ?? "NO JSON STRING")")
                        let decoder = JSONDecoder()
                        let object = try decoder.decode(BaseModel.self, from: response.data)
                        let error = NSError(domain: Constant.kDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: object.message ?? "Unable to connect"])
                        errorCallBack(CustomError.HTTPError(err: error))
                    }
                    catch {
                        errorCallBack(CustomError.ParsingError)
                    }
                }
                else {
                    do {
                        let strJson = String(data: response.data, encoding: .utf8)
                        print("RESPONSE JSON: \(strJson ?? "NO JSON STRING")")
                        
                        let decoder = JSONDecoder()
                        let object = try decoder.decode(BaseModel.self, from: response.data)
                        let error = NSError(domain: Constant.kDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: object.message ?? "Unable to connect"])
                        errorCallBack(CustomError.HTTPError(err: error))
                    }
                    catch {
                        errorCallBack(CustomError.ParsingError)
                    }
                }
            case .failure(let error):
                print("FAILED:  \(MoyaError.underlying(error, nil))")
                NetworkManager.isUnreachable { resultsss in
                   failureCallBack(CustomError.NoNetwork)
                }
                switch error {
                case .underlying(let err as NSError, _):
                    print(err.code)
                    print(err.domain)
                    
                    if err.code == 1009 {
                        failureCallBack(CustomError.NoNetwork)
                    }
                    else if err.code == 2102 {
                        failureCallBack(CustomError.TimeOut)
                    }
                    else {
                        failureCallBack(CustomError.FirebaseError(errorMsg: error.localizedDescription))
                    }
                    
                default:
                    failureCallBack(CustomError.BadRequest)
                }
            }
        }
    }
    
    
//    class func logoutFromApp(){
//
//
//
//        let loginVC = Constant.getViewController(storyboard: Constant.kMainStoryboard, identifier: Constant.kLoginVC, type: LoginVC.self)
//    //    loginVC.hidesBottomBarWhenPushed = true
//
//
//
//        //let appDel = UIApplication.shared.delegate as! AppDelegate
//
//
//
//            let alert = UIAlertController(title: "", message: "Session expired.", preferredStyle: .alert)
//            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alert.addAction(alertAction)
//            loginVC.present(alert, animated: true, completion: {
//                 UserDefaults.standard.setLoggedIn(value: false)
//                let navController = UINavigationController(rootViewController: loginVC)
//                let appDel = UIApplication.shared.delegate as! AppDelegate
//                appDel.window?.rootViewController = navController
//            })
//
//    }
}
