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
    }
    @IBAction func termBtn(_ sender: Any) {
    }
    @IBAction func contactBtn(_ sender: Any) {
    }
    @IBAction func aboutBtn(_ sender: Any) {
    }
    @IBAction func faqBtn(_ sender: Any) {
    }
    @IBAction func homeBtn(_ sender: Any) {
    }
    @IBAction func closeBtn(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signoutBtn(_ sender: Any) {
        
        AuthenticationManager.instance.signOut()
        self.performSegue(withIdentifier: "userSignedOut", sender: nil)
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
