//
//  RoomBookMainVC.swift
//  Staqo
//
//  Created by SHAILY on 02/04/21.
//

import UIKit

class RoomBookMainVC: UIViewController {
    @IBOutlet weak var roomSearchTap: UIButton!
    @IBOutlet weak var approveCancelTap: UIButton!
   
    @IBOutlet weak var scanShadowView: UIView!
    @IBOutlet weak var businessShadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        businessShadowView.dropShadow()
        scanShadowView.dropShadow()
        approveCancelTap.layer.cornerRadius = 11
        
        roomSearchTap.layer.cornerRadius = 11
        approveCancelTap.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        roomSearchTap.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
    }
    
    @IBAction func roomSearchTap(_ sender: Any) {
        let vc = Constant.getViewController(storyboard: Constant.kRoomStroyboard, identifier: Constant.kRoomBookingVC, type: RoomBookingVC.self)

        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func approveCancelTap(_ sender: Any) {
        
        let vc = Constant.getViewController(storyboard: Constant.kRoomStroyboard, identifier: Constant.kApproveCancelVC, type: ApproveCancelVC.self)

        self.navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)

    }


}
