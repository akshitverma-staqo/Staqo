//
//  DashboardNavigationVC.swift
//  
//
//  Created by apple on 04/04/19.
//  Copyright © 2019 ESoft Technologies. All rights reserved.
//

import UIKit

@available(iOS 12.0, *)
class DashboardNavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let image = UIImage(named: "back_arrow")
//        self.navigationBar.backIndicatorImage = image
//        self.navigationBar.backIndicatorTransitionMaskImage = image
//        self.navigationBar.tintColor = UIColor.white
        
       // self.navigationController?.navigationItem.backBarButtonItem?.title = ""

        var colors:[Any] = []
        if #available(iOS 11.0, *) {
            colors = [UIColor(named: "NavGreen")?.cgColor as Any, UIColor(named: "NavBlue")?.cgColor as Any]
        } else {
            // Fallback on earlier versions
        }
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        var bounds = self.navigationBar.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = colors
      //  self.navigationBar.setBackgroundImage(self.image(gradientLayer: gradient), for: .default)
        
        
       // let logoutBtn = UIBarButtonItem(image: UIImage(named: "logout"), style: .done, target: self, action: #selector(DashboardNavigationVC.logoutBtnTapped))
       // self.navigationItem.rightBarButtonItems = [logoutBtn]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//          let logoutBtn = UIButton(type: .custom)
//           logoutBtn.setImage(UIImage(named: "logout"), for: .normal)
//           logoutBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//           logoutBtn.addTarget(self, action: #selector(DashboardNavigationVC.logoutBtnTapped), for: .touchUpInside)
//           let item = UIBarButtonItem(customView: logoutBtn)
//
//         self.navigationItem.rightBarButtonItem = item
//        navigationBar.setItems([self.navigationItem], animated: true)
    }
    @objc func logoutBtnTapped(){
         let loginVC = Constant.getViewController(storyboard: Constant.kMainStoryboard, identifier: Constant.kLoginVC, type: LoginVC.self)
        self.pushViewController(loginVC, animated: true)
            }
        
    
    private func image(gradientLayer: CAGradientLayer) -> UIImage? {
        
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    

    /*
    // // MARK:- : -- Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


