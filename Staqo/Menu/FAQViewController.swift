//
//  SevenViewController.swift
//  DemoApp
//
//  Created by ERP on 21/01/21.
//  Copyright © 2021 ERP. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class FAQViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var herderView: HeaderView!

    var header:HeaderView!
    
    @IBOutlet weak var webView: WKWebView!
    var accessToken = ""
    
    @IBOutlet weak var tableView: UITableView!
    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:100))
        header.delegate = self
       
        herderView.addSubview(header)
        tableViewData = [cellData(opened: true, title: "What is OQ mobile application?", sectionData: ["OQ Mobile App is a facility provided to you by OQ to access Company Services any time anywhere in a smart way for 24/7,365 days a year. It is available for Android and IOS devices."]),
                         cellData(opened: false, title: "Can I edit my profile?", sectionData: ["No, user cannot edit the profile."]),
                         cellData(opened: false, title: "Will I be able to use all the features in the mobile app straight away?", sectionData: ["All @oq.com employees will have access to the app."]),
                         cellData(opened: false, title: "What are the objectives of the Mobile App?", sectionData: ["This app acts as a container of the most important systems in OQ and to be accessed through mobile."]),
                         cellData(opened: false, title: "Will I be notified if new content is uploaded in the app?", sectionData: ["Yes, you will be notified."]),
                         cellData(opened: false, title: "What can I access through the app?", sectionData: ["OQ portal Salmeen and COVID-19 declaration form Mazayacom I-HSSE (Incident reporting) Your own Business card. Global offices"]),
                         cellData(opened: false, title: "I am not able to access the new app, why?", sectionData: ["All employees with @oq.com email domain will be able to access the mobile app."]),
                         cellData(opened: false, title: "Why does OQ need a mobile app?", sectionData: ["To serve you better in your day to day activities."]),
                         cellData(opened: false, title: "What is the name of the app?", sectionData: ["OQ Mobile App "]),
                         cellData(opened: false, title: "Will there be one single login and password to access everything?", sectionData: ["Yes."]),
                         cellData(opened: false, title: "What if I have more queries on OQ mobile app?", sectionData: ["Contact Help Desk at helpdesk@oq.com or chat with a help desk employee at OQ Help Desk on Microsoft Teams."]),
                         cellData(opened: false, title: "Is the App safe and secure?", sectionData: ["OQ Cyber Security is committed to ensuring the security and confidentiality of our systems and technology. While we do our utmost to ensure the security of our systems, there are steps you need to take as well to ensure your security. Please visit the OQ Cyber Security page on the intranet for further details."]),
        ]
        
     
        
        
        tableView.register(UINib(nibName: "FAQHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "FAQHeaderTableViewCell")
        tableView.register(UINib(nibName: "FAQAnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "FAQAnswerTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        header.btnNotiyCount.setTitle("\(UserDefaults.standard.getNotifyCount() )", for: .normal)

        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
    
    
   
}
extension FAQViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true{
            return tableViewData[section].sectionData.count + 1
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FAQHeaderTableViewCell") as? FAQHeaderTableViewCell
            cell?.titleLabel.text = tableViewData[indexPath.section].title
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FAQAnswerTableViewCell") as? FAQAnswerTableViewCell
            cell?.answerLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if tableViewData[indexPath.section].opened == true{
                tableViewData[indexPath.section].opened = false
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .none)
            }else{
                tableViewData[indexPath.section].opened = true
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .none)
            }
        }
    }
}
extension FAQViewController: HeaderViewDelegate{
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
