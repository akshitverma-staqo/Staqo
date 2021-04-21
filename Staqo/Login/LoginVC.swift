//
//  LoginVC.swift
//  Staqo
//
//  Created by Esoft on 11/02/21.
//

import UIKit
import LocalAuthentication

class LoginVC: BaseVC {
    var viewModel:LoginViewModel!
    
    @IBOutlet weak var xConstraint: NSLayoutConstraint!
    @IBOutlet weak var yConstraint: NSLayoutConstraint!
    @IBOutlet weak var halfLogo: UIImageView!
    @IBOutlet weak var horizantalConstraint: NSLayoutConstraint!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var shadowView: UIView!
    var context = LAContext()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(dataSource: LoginDataSource())
        viewModel.delegate = self
        
        shadowView.dropShadow()
        innerView.layer.cornerRadius  = 11
        innerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
      //  UserDefaults.standard.setMenuValue(value: true)
        print(Configuration.baseURL)
        self.navigationController?.isNavigationBarHidden = true
        
        // Do any additional setup after loading the view.
    }

    @IBAction func singInTapped(_ sender: UIButton) {
        viewModel.signInAthentication(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        horizantalConstraint.constant = -414
        yConstraint.constant = (view.bounds.height)
        xConstraint.constant = view.bounds.width / 2
        
        let jail = jailBreak()
        if jail {
            Auth()
        }else{
            showErrorMessage(title: "Unauthorize Installation.", message: "Your Device is Jailbreak") { (action) in
                exit(0)
            }
        }
        
      
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        horizantalConstraint.constant = 0
        yConstraint.constant = 80
        xConstraint.constant = -95
        UIView.animate(withDuration: 1.0, delay: 1.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
            self.halfLogo.transform = CGAffineTransform(rotationAngle: (360.0 * .pi) / 90.0)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}
extension LoginVC : ViewModelDelegate{
    func willLoadData() {
        startLoader()
    }
    
    func didLoadData() {
        stopLoader()
        
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kHomeVC, type: HomeVC.self)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func didFail(error: CustomError) {
        showErrorMessage(title: "Error", error: error) { (action) in
            
        }
        stopLoader()
    }
    
    
}
//MARK:- Phone Lock Authentication / Also chacking the JailBreak
extension LoginVC{
    
    func Auth() {
        // Get a fresh context for each login. If you use the same context on multiple attempts
        //  (by commenting out the next line), then a previously successful authentication
        //  causes the next policy evaluation to succeed without testing biometry again.
        //  That's usually not what you want.
        context = LAContext()
        
        context.localizedCancelTitle = "OK"
        
        // First check if we have the needed hardware support.
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            let reason = "Log in to your account"
            print("step 1")
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                
                if success {
                    print("step 2")
                    // Move to the main thread because a state update triggers UI changes.
                    DispatchQueue.main.async { [unowned self] in
                        self.viewModel.bootstrap()
                    print("step 3")
                    }
                    
                } else {
                    print(error?.localizedDescription ?? "Failed to authenticate")
                    print("step 4")
                    // Fall back to a asking for username and password.
                    // ...
                    DispatchQueue.main.async { [unowned self] in
                        
                        showMessageWithOneArgument(title: "Alert", message: "For your security, you can only use OQ Employee App when It's Unlocked.", btnConfirmTitle: "Unlock") { (isUnlock, action)  in
                            if isUnlock {
                                Auth()

                            }
                        }
                        
                        
                        
                   
                        
                    }
                }
            }
        } else {
            print(error?.localizedDescription ?? "Can't evaluate policy")
            print("step 5")
            // Fall back to a asking for username and password.
            // ...
        }
        
        
        
        
        
    }
    
    
    func jailBreak() -> Bool{
        
//        if TARGET_IPHONE_SIMULATOR != 1
//        {
            // Check 1 : existence of files that are common for jailbroken devices
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
                || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                || FileManager.default.fileExists(atPath: "/bin/bash")
                || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                || FileManager.default.fileExists(atPath: "/etc/apt")
                || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
                || UIApplication.shared.canOpenURL(URL(string:"cydia://package/com.example.package")!)
            {
                return true
            }
            // Check 2 : Reading and writing in system directories (sandbox violation)
            let stringToWrite = "Jailbreak Test"
            do
            {
            try stringToWrite.write(toFile:"/private/JailbreakTest.txt", atomically:true, encoding:String.Encoding.utf8)
            //Device is jailbroken
            print("@@@@@Device is jailbreak")

            return true
        }catch
        {
            print("@@@@@Device not jailbreak1")
            return true
        }
    }
}
