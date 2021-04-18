//
//  NineViewController.swift
//  DemoApp
//
//  Created by ERP on 19/01/21.
//  Copyright © 2021 ERP. All rights reserved.
//

import UIKit
import Alamofire
import WebKit
class ContactViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var herderView: HeaderView!

    var header:HeaderView!
    @IBOutlet weak var bottomInnerView: UIView!
    @IBOutlet weak var bottomShadow: UIView!
    @IBOutlet weak var middleEstInnerview: UIView!
    
    @IBOutlet weak var supportFormView: UIView!
    @IBOutlet weak var globalPresenceView: UIView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var globalSuportBackView: UIView!
    @IBOutlet weak var contactInnerView: UIView!
    @IBOutlet weak var contactBackView: UIView!
    @IBOutlet weak var rayustShadow: UIView!
    @IBOutlet weak var rayustInnerView: UIView!
    @IBOutlet weak var controlShadow: UIView!
    @IBOutlet weak var controlInnerView: UIView!
    @IBOutlet weak var suharShadow: UIView!
    @IBOutlet weak var suharInnerView: UIView!
    @IBOutlet weak var mafShadow: UIView!
    @IBOutlet weak var mafInnerView: UIView!
    @IBOutlet weak var worldShadow: UIView!
    @IBOutlet weak var worldInnerView: UIView!
    @IBOutlet weak var wordWideShadow: UIView!
    @IBOutlet weak var worldWideInnerViw: UIView!
    @IBOutlet weak var chinaShadow: UIView!
    @IBOutlet weak var chinaInnerView: UIView!
    @IBOutlet weak var usaShadow: UIView!
    @IBOutlet weak var usaInnerView: UIView!
    @IBOutlet weak var helpDeskShadow: UIView!
    @IBOutlet weak var helpDeskinnerview: UIView!
    
    
    @IBOutlet weak var webVIew: WKWebView!
    
    var accessToken = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:100))
        header.delegate = self
       
        herderView.addSubview(header)
        helpDeskShadow.dropShadow()
        helpDeskinnerview.layer.cornerRadius = 11
        usaShadow.dropShadow()
        usaInnerView.layer.cornerRadius = 11
        chinaShadow.dropShadow()
        chinaInnerView.layer.cornerRadius = 11
        wordWideShadow.dropShadow()
        worldWideInnerViw.layer.cornerRadius = 11
        worldShadow.dropShadow()
        worldInnerView.layer.cornerRadius = 11
        mafShadow.dropShadow()
        mafInnerView.layer.cornerRadius = 11
        suharShadow.dropShadow()
        suharInnerView.layer.cornerRadius = 11
        
        controlShadow.dropShadow()
        controlInnerView.layer.cornerRadius = 11
        bottomShadow.dropShadow()
        bottomInnerView.layer.cornerRadius = 11
        
        rayustShadow.dropShadow()
        rayustInnerView.layer.cornerRadius = 11
        
       
       
        picture.layer.cornerRadius = 11
        picture.clipsToBounds = true
        globalPresenceView.layer.cornerRadius = 11
        globalPresenceView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        supportFormView.dropShadow()
        middleEstInnerview.layer.cornerRadius = 11
        
    
        // Adding webView content
        do {
            guard let filePath = Bundle.main.path(forResource: "contact", ofType: "html")
            else {
                // File Error
                print ("File reading error")
                return
            }
            
            let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: filePath)
            // webVIew.loadHTMLString(contents as String, baseURL: baseUrl)
        }
        catch {
            print ("File HTML error")
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        header.btnNotiyCount.setTitle("\(UserDefaults.standard.getNotifyCount() )", for: .normal)

        self.navigationController?.isNavigationBarHidden = true
    }
    
    
}
extension ContactViewController: HeaderViewDelegate{
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

