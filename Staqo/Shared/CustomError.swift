//
//  CustomError.swift
//  
//
//  Created by apple on 27/03/19.
//  Copyright © 2019 ESoft Technologies. All rights reserved.
//

import Foundation

protocol Printable {
    var localizedDescription:String {get}
}

enum CustomError:Printable {
    case FirebaseError(errorMsg: String)
    case NoNetwork //1009
    case HTTPError(err:Error)
    case ServerError
    case TimeOut //2102
    case ParsingError
    case BadRequest
    case InValidUserName
    case InValidNoLength
    case NoForms
    case Logout
    case NoContent
    case DownloadFailed
    case Saved
    case SavingFailed
    case EmptyComment
    case PickerValue
    case SessionExpired
    case ResetPasswordFail
    case ResetPassword
    case Otp
    case QrCodeGenerated
    case OtherError(error: Error)
    
    var localizedDescription: String {
        switch  self {
        case .FirebaseError(let errorMsg):
            return errorMsg
        case .NoNetwork:
            return "No Network"
        case .HTTPError(let error):
            return "\(error.localizedDescription)"
        case .TimeOut:
            return "The request has timed out"
        case .ParsingError:
            return "Unable to Serialize"
        case .BadRequest:
            return "Something went wrong"
        case .InValidUserName:
            return "Please Enter Valid Email Address"
        case .InValidNoLength:
            return "Phone number entered should be of minimum 10 digits"
        case .NoForms:
            return "Selected form not available."
        case .Logout:
            return "You are about to logout, click Yes to end the session or cancel to continue."
        case .NoContent:
            return "There are no contents available for the selection."
        case .DownloadFailed:
            return "We were unable to download, try later."
        case .Saved:
            return "Data saved successfully."
        case .SavingFailed:
            return "Unable to save, try later."
        case .EmptyComment:
            return "Please Mention the Reason"
        case .SessionExpired:
            return "Session expired."
        case .ResetPasswordFail:
            return "Reset Failed"
        case .ResetPassword:
            return "Reset Password email sent successfully"
        case .Otp:
            return "Please enter the valid Otp Number"
        case .QrCodeGenerated:
            return "QR code can't be generate, without any contact number."
        case .OtherError(let error):
        return error.localizedDescription
            
        default:
            return ""
        }
    }
}

//enum CustomError:Error {
//
//    case BadRequest
//    case NoNetwork //1009
//    case ParsingError
//    case TimeOut // 2102
//
//    var errorDescription:String {
//
//        switch self {
//        case .NoNetwork:
//            return "No Network"
//        default:
//            return "Un-Identified Error"
//        }
//    }
//}
