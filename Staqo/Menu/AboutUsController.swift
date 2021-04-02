//
//  AboutUsController.swift
//  OQ
//
//  Created by Bennett University on 20/01/21.
//

import UIKit
import Alamofire
class AboutUsController: UIViewController {
    
    @IBOutlet weak var herderView: HeaderView!

    var header:HeaderView!
        
    @IBOutlet weak var firstLabel: UILabel!
    var accessToken = ""
    var descriptionStringTwo = "OQ is a global integrated energy company with roots in Oman. It emerged in late 2019 upon the successful integration of nine legacy companies, united to form a stronger, more efficient, and consolidated entity. "
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:100))
        header.delegate = self
       
        herderView.addSubview(header)
       
        
        let  organizationSettingString = NSMutableAttributedString(string: descriptionStringTwo, attributes: [
            .foregroundColor: UIColor(red: 36 / 255, green: 77 / 255, blue: 96 / 255, alpha: 1.0),
            .kern: 0.0
        ])
        organizationSettingString.addAttributes([
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor(red: 36 / 255, green: 77 / 255, blue: 96 / 255, alpha: 1.0),
        ], range: NSRange(location: 0, length: 59))
        firstLabel.attributedText = organizationSettingString
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        self.navigationController?.isNavigationBarHidden = true
    }
    
   
   
}

extension AboutUsController: HeaderViewDelegate{
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
