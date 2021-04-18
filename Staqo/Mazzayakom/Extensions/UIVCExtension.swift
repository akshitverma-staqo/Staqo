//
//
//import UIKit
//import Alamofire
//extension UIViewController    {
//    
//    func commonNavigationBar(controller:Constant1.Controllers)
//    {
//        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
//        
//        
//        switch (controller){
//        case .dashboard:
//            
//            let menu = UIButton(type: .custom)
//            menu.setImage(UIImage(named: "menu_icon"),for: .normal)
//            menu.addTarget(self, action: #selector(menuOpen), for: .touchUpInside)
//            
//            let menuBar = UIBarButtonItem(customView: menu)
//            
//            self.navigationItem.leftBarButtonItem  = menuBar
//            
//            
//            
//            
//            
//            var accessToken = ""
//            accessToken = UserDefaults.standard.getAccessToken()
//            print(" AccessToekn+++ " + accessToken)
//            
//            let headers: HTTPHeaders = [
//                "Authorization": "Bearer "+accessToken+""
//                
//            ]
//            let urlStr = "https://graph.microsoft.com/v1.0/me/photo/$value"
//            //print("this is the URL::::::::::::::" + urlStr)
//            
//            AF.request(urlStr, headers: headers)
//            //NetworkClient.request(url: urlStr, parameters: nil, headers: headers)
//                .response { [self] response in
//                    
//                    print("Response value")
//                    print(response)
//                    if let data = response.data {
//                        do{
//                            
//                            print(data)
//                            
//                            let profile = UIButton(type: .custom)
//                            
//                            
//                            if let _ = UIImage(data: data) {
//                                print("data contains image data")
//                                let image = UIImage(data: data)
//                                profile.setImage(image , for: .normal)
//                            } else {
//                                print("data does not contain image data")
//                                profile.setImage(#imageLiteral(resourceName: "profiled") , for: .normal)
//                            }
//                            
//                            
//                            
//                            //  let image = UIImage(data: data)
//                            
//                            profile.addTarget(self, action: #selector(self.profileOpen), for: .touchUpInside)
//                            
//                            profile.heightAnchor.constraint(equalToConstant: 45).isActive = true
//                            profile.widthAnchor.constraint(equalToConstant: 45).isActive = true
//                            profile.layer.cornerRadius = 22.5
//                            profile.layer.borderWidth = 0.5
//                            profile.layer.borderColor = UIColor.clear.cgColor
//                            profile.clipsToBounds = true
//                            let profileBar = UIBarButtonItem(customView: profile)
//                            
//                            
//                            let button2 = UIButton(type: .custom)
//                            button2.setTitle(title, for: .normal)
//                            button2.heightAnchor.constraint(equalToConstant: 26).isActive = true
//                            button2.widthAnchor.constraint(equalToConstant: 26).isActive = true
//                            button2.layer.cornerRadius = 13
//                            button2.clipsToBounds = true
//                            //button2.backgroundColor =  .appPink
//                            // button2.titleLabel?.font = .smallFont
//                            button2.setTitle("", for: .normal)
//                            button2.setTitleColor(.white, for: .normal)
//                            let barButtonItem2 = UIBarButtonItem(customView: button2)
//                            
//                            
//                            let notification = UIButton(type: .custom)
//                            notification.setImage(#imageLiteral(resourceName: "notification") , for: .normal)
//                            notification.addTarget(self, action: #selector(self.notification), for: .touchUpInside)
//                            notification.heightAnchor.constraint(equalToConstant: 20).isActive = true
//                            notification.widthAnchor.constraint(equalToConstant: 17).isActive = true
//                            let notificationBar = UIBarButtonItem(customView: notification)
//                            
//                            
//                            
//                            self.navigationItem.rightBarButtonItems  = [notificationBar,  barButtonItem2, profileBar]
//                            // self.profileImage.image = UIImage(data: data)
//                        }
//                    }
//                    
//                    
//                }
//            
//            
//            
//            
//            //let image = UIImage(data: data)
//            
//            
//            
//            
//            
//            
//            
//            
//            
//            break
//            
//        case .listing, .bottomSwipe:
//            
//            
//            let back = UIButton(type: .custom)
//            back.setImage(UIImage(named: "back"),for: .normal)
//            back.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
//            let menuBar = UIBarButtonItem(customView: back)
//            
//            self.navigationItem.leftBarButtonItem  = menuBar
//            
//            
//            break
//            
//        case .saveContact:
//            
//            
//            let back = UIButton(type: .custom)
//            back.setImage(UIImage(named: "back"),for: .normal)
//            back.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
//            let menuBar = UIBarButtonItem(customView: back)
//            
//            self.navigationItem.leftBarButtonItem  = menuBar
//            
//            
//            
//            let profile = UIButton(type: .custom)
//            profile.setImage(#imageLiteral(resourceName: "notification") , for: .normal)
//            profile.heightAnchor.constraint(equalToConstant: 45).isActive = true
//            profile.widthAnchor.constraint(equalToConstant: 45).isActive = true
//            let profileBar = UIBarButtonItem(customView: profile)
//            
//            
//            let notification = UIButton(type: .custom)
//            notification.setImage(#imageLiteral(resourceName: "notification") , for: .normal)
//            notification.heightAnchor.constraint(equalToConstant: 20).isActive = true
//            notification.widthAnchor.constraint(equalToConstant: 17).isActive = true
//            let notificationBar = UIBarButtonItem(customView: notification)
//            
//            
//            
//            self.navigationItem.rightBarButtonItems  = [notificationBar, profileBar]
//            
//            
//            break
//            
//            
//            
//            
//        case .backBottom:
//            
//            let back = UIButton(type: .custom)
//            back.setImage(UIImage(named: "back"),for: .normal)
//            back.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
//            let menuBar = UIBarButtonItem(customView: back)
//            
//            self.navigationItem.leftBarButtonItem  = menuBar
//            
//            
//            break
//            
//            
//            
//            
//        }
//    }
//    
//    @objc func backBtnClicked()
//    {
//        
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    
//    @objc func menuOpen()
//    {
////        print("MenuViewController")
////        let vc = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
////        vc!.modalPresentationStyle = .fullScreen
////        present(vc!, animated: true, completion: nil)
//        
//        
//        
//    }
//    
//    @objc func notification()
//    {
//        print("NotificationViewController")
//        let vc = storyboard?.instantiateViewController(withIdentifier: Constant.kNotificationVC) as? NotificationVC
//        vc!.modalPresentationStyle = .fullScreen
//        present(vc!, animated: true, completion: nil)
//        
//        
//        
//    }
//    
//    @objc func profileOpen()
//    {
//        print("EmpProfile")
//        let vc1 = storyboard?.instantiateViewController(withIdentifier: Constant.kEmpVC) as? EmpVC
//        vc1!.modalPresentationStyle = .fullScreen
//        present(vc1!, animated: true, completion: nil)
//        
//        
//        
//    }
//    
//    
//    
//    static  func setAttributedString(str: String,str1:String,str2:String) -> NSMutableAttributedString{
//        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: str)
//        attributedString.setColor(color: #colorLiteral(red: 0.9921568627, green: 0.2274509804, blue: 0.4745098039, alpha: 1), forText: str2)
//        attributedString.setColor(color: #colorLiteral(red: 0.1411764706, green: 0.3019607843, blue: 0.3764705882, alpha: 1), forText: str1)
//        return attributedString
//        
//    }
//    
//    // MARK:- Email validation
//    func isValidEmail(testStr:String) -> Bool {
//        
//        let emailRegEx = "^[a-zA-Z][A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,4}$"
//        let trimmedString = testStr.trimmingCharacters(in: .whitespaces)
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        let result = emailTest.evaluate(with: trimmedString)
//        return result
//        
//    }
//    
//    // MARK:- username Validation
//    func isValidUsrName(testStr:String) -> Bool {
//        
//        guard testStr.count > 2, testStr.count < 18 else { return false }
//        
//        return true
//    }
//    
//    //MARK:- Mobile Number Validation
//    func isValidMblNum(testStr:String) -> Bool {
//        
//        print("validate MblNum: \(testStr)")
//        let mblNumRegEx = "^\\d{10}$"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", mblNumRegEx)
//        let result = emailTest.evaluate(with: testStr)
//        return result
//        
//    }
//    
//    
//    
//    @objc func backButtonClicked()
//    {
//        self.navigationController?.popViewController(animated: true);
//    }
//    
//    @objc func notificationBtnClickd()
//    {
//        
//    }
//    
//    
//    
//    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//    
//    
//    
//    
//    
//}
//
//extension NSMutableAttributedString {
//    
//    func setColor(color: UIColor, forText stringValue: String) {
//        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
//        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
//    }
//    
//}
//
//
