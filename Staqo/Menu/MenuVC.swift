//
//  MenuVC.swift
//  Staqo
//
//  Created by SHAILY on 06/03/21.
//

import UIKit

class MenuVC: BaseVC {
    
    var viewModal: MenuViewModal!

    var descriptionStringTwo = "©2020 OQ SAOC. Powered by Staqo"
    @IBOutlet weak var bottomLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        let  organizationSettingString = NSMutableAttributedString(string: descriptionStringTwo, attributes: [
            .foregroundColor: UIColor(red: 105 / 255, green: 105 / 255, blue: 105 / 255, alpha: 1.0),
            .kern: 0.0
        ])
        organizationSettingString.addAttributes([
            .foregroundColor: UIColor(red: 28 / 255, green: 29 / 255, blue: 76 / 255, alpha: 1.0),
        ], range: NSRange(location: 26, length: 5))
        bottomLabel.attributedText = organizationSettingString
        
    }
    @IBAction func privacyBtn(_ sender: Any) {
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kPrivacyViewController, type: PrivacyViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func termBtn(_ sender: Any) {
        
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kTermConditionViewController, type: TermConditionViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func contactBtn(_ sender: Any) {
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kContactViewController, type: ContactViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func aboutBtn(_ sender: Any) {
        
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kAboutUsController, type: AboutUsController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func faqBtn(_ sender: Any) {
        
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kFAQViewController, type: FAQViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func homeBtn(_ sender: Any) {
        
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kHomeVC, type: HomeVC.self)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func closeBtn(_ sender: Any){
        self.navigationController?.isNavigationBarHidden = false

        _ = navigationController?.popViewController(animated: true)

    }
    @IBAction func signoutBtn(_ sender: Any) {
        
        AuthenticationManager.instance.signOut()
       
        let vc = Constant.getViewController(storyboard: Constant.kMainStoryboard, identifier: Constant.kLoginVC, type: LoginVC.self)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
        
        
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
extension MenuVC: ViewModelDelegate{
    func willLoadData() {
        startLoader()

    }
    
    func didLoadData() {
        
        stopLoader()
        
        
        
    }
    
    func didFail(error: CustomError) {
        showErrorMessage(title: "Error", error: error) { (action) in
            
        }
        stopLoader()
    }
    
    
}
