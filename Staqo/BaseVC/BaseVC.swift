//
//  BaseVC.swift
//
//
//  Created by apple on 27/03/19.
//  Copyright © 2019 ESoft Technologies. All rights reserved.
//

import UIKit
import SVProgressHUD


class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setDefaultStyle(.dark)
    }
    
    func startLoader() {
        
        self.view.isUserInteractionEnabled = false
        SVProgressHUD.show()
    }
    
    func stopLoader() {
        self.view.isUserInteractionEnabled = true
        SVProgressHUD.dismiss()
    }
    
     func showErrorMessage(title:String, error:CustomError , handler: @escaping(UIAlertAction)-> Void) {
           
           let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
           let alertAction = UIAlertAction(title: "OK", style: .cancel){ (action) in
               handler(action)
           }
           alert.addAction(alertAction)
           self.present(alert, animated: true, completion: nil)
       }
    
    func showErrorMessage(title: String, message: String, handler: @escaping(UIAlertAction)-> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            handler(action)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessage(title: String, message: String, btnConfirmTitle: String, btnCancelTitle: String,  handler:@escaping (Bool, UIAlertAction)->Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnConfirmAction = UIAlertAction(title: btnConfirmTitle, style: .default) { (action) in
            handler(true, action)
        }
        let btnCancelAction = UIAlertAction(title: btnCancelTitle, style: .cancel) { (action) in
            handler(false, action)
        }
        
        alert.addAction(btnCancelAction)
        alert.addAction(btnConfirmAction)
        
        self.present(alert, animated: true) {
            
        }
    }
    
//   func logoutFromApp(){
//       showMessage(title: Constant.kAlertTitle_LOGOUT, message: CustomError.Logout.localizedDescription, btnConfirmTitle: Constant.kAlertAction_YES, btnCancelTitle: Constant.kAlertAction_CANCEL) { (isConfirmTapped, action) in
//
//                    if isConfirmTapped {
//                        let loginVC = Constant.getViewController(storyboard: Constant.kMainStoryboard, identifier: Constant.kLoginVC, type: LoginVC.self)   //self.storyboard?.instantiateViewController(withIdentifier: Constant.kLoginVC) as! LoginVC
//                                                UserDefaults.standard.setLoggedIn(value: false)
//                                                let navController = UINavigationController(rootViewController: loginVC)
//                                                   navController.isNavigationBarHidden = true
//                                                let appDel = UIApplication.shared.delegate as! AppDelegate
//                                                appDel.window?.rootViewController = navController
//                    //    self.present(loginVC, animated: true, completion: nil)
//                    }
//                }
//    }
    
    
}

extension BaseVC : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        //let max:Int = UserDefaults.standard.object(forKey: "maxlenght")! as! Int
        return changedText.count <= 240
    }
}

