//
//  TwelveViewController.swift
//  DemoApp
//
//  Created by ERP on 20/01/21.
//  Copyright © 2021 ERP. All rights reserved.
//

import UIKit
import Alamofire
import WebKit
class PrivacyViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var herderView: HeaderView!

    var header:HeaderView!
    @IBOutlet weak var webView: WKWebView!
    var accessToken = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:70))
        header.delegate = self
       
        herderView.addSubview(header)
        
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        header.btnNotiyCount.setTitle("\(UserDefaults.standard.getNotifyCount() )", for: .normal)

        self.navigationController?.isNavigationBarHidden = true
    }
    
}
extension PrivacyViewController: HeaderViewDelegate{
    func btnMenuTapped(sender: UIButton) {
        
        _ = navigationController?.popViewController(animated: true)

    }
    
    func btnProfileTapped(sender: UIButton) {
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kEmpVC, type: EmpVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func btnLogoutTapped(sender: UIButton) {
        
        let vc = Constant.getViewController(storyboard: Constant.kNotification, identifier: Constant.kNotificationVC, type: NotificationVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
