//
//  RoomBookMainVC.swift
//  Staqo
//
//  Created by SHAILY on 02/04/21.
//

import UIKit

class RoomBookMainVC: UIViewController {
    @IBOutlet weak var scanBtnOutlet: UIButton!
    @IBOutlet weak var businessBtnOutlet: UIButton!
    @IBOutlet weak var scanShadowView: UIView!
    @IBOutlet weak var businessShadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        businessShadowView.dropShadow()
        scanShadowView.dropShadow()
        businessBtnOutlet.layer.cornerRadius = 11
        
        scanBtnOutlet.layer.cornerRadius = 11
        businessBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        scanBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func roomSearchTap(_ sender: Any) {
        let vc = Constant.getViewController(storyboard: Constant.kRoom, identifier: Constant.kRoomBookingVC, type: RoomBookingVC.self)

        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func approveCancelTap(_ sender: Any) {
        let vc = Constant.getViewController(storyboard: Constant.kRoom, identifier: Constant.kBooKRoomVC, type: BooKRoomVC.self)

        self.navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
