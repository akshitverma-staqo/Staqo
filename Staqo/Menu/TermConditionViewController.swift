//
//  ElevenViewController.swift
//  DemoApp
//
//  Created by ERP on 20/01/21.
//  Copyright © 2021 ERP. All rights reserved.
//

import UIKit
import Alamofire
import WebKit
class TermConditionViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var herderView: HeaderView!

    var header:HeaderView!
    var accessToken = ""
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:70))
        header.delegate = self
       
        herderView.addSubview(header)
        
        // Do any additional setup after loading the view.
        
        
        
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        header.btnNotiyCount.setTitle("\(UserDefaults.standard.getNotifyCount() )", for: .normal)

        self.navigationController?.isNavigationBarHidden = true
    }
    
    
}
extension TermConditionViewController: HeaderViewDelegate{
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
