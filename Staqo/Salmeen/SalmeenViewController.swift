//
//  TwentyTwoViewController.swift
//  DemoApp
//
//  Created by ERP on 19/01/21.
//  Copyright © 2021 ERP. All rights reserved.
//

import UIKit

class SalmeenViewController: UIViewController {


    @IBOutlet weak var declerationBtnOutlet: UIButton!
    @IBOutlet weak var covieBtnOutlet: UIButton!
    @IBOutlet weak var declerationBtnShadowView: UIView!
    @IBOutlet weak var covidBtnShadowView: UIView!
    @IBOutlet weak var bottomView: UIView!
    var url: URL!
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [. layerMinXMinYCorner, .layerMaxXMinYCorner]
        covidBtnShadowView.dropShadow()
        declerationBtnShadowView.dropShadow()
        covieBtnOutlet.layer.cornerRadius = 10
        declerationBtnOutlet.layer.cornerRadius = 10
        covieBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner]
        
        declerationBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner]

        
    }
    
    @IBAction func sefdecBtnTap(_ sender: Any) {
        

       // UserDefaults.standard.set("salmeen2", forKey: "webcheck")
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kWebViewVC, type: WebViewVC.self)
        vc.url = URL(string:Constant.kSALMEEN_POINT2)
        vc.linkName = "Self-declaration"
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    @IBAction func covieBtnTap(_ sender: Any) {
        
        
//        UIApplication.shared.open(URL(string: "https://thisisoq.sharepoint.com/Pages/Salmeen.aspx")!, options: [:], completionHandler: nil)

        
       
        //UserDefaults.standard.set("salmeen1", forKey: "webcheck")
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kWebViewVC, type: WebViewVC.self)
        vc.url = URL(string:Constant.kSALMEEN_POINT1)
        vc.linkName = "COVID-19 Info"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func backBtn(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)

        
    }
}
