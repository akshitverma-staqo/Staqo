//
//  RoomPhotoVC.swift
//  Staqo
//
//  Created by SHAILY on 02/04/21.
//

import UIKit

class RoomPhotoVC: UIViewController {
    var header:HeaderView!
    @IBOutlet weak var herderView: HeaderView!
    @IBOutlet weak var imageView: UIImageView!
    var urlString:String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:70))
        header.delegate = self
        herderView.addSubview(header)
        if let url = urlString {
            imageView.image = UIImage(contentsOfFile:url)
        }
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        header.btnNotiyCount.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
}
extension RoomPhotoVC: HeaderViewDelegate{
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

