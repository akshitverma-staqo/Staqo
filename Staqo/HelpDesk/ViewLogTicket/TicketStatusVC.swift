//
//  TicketStatusVC.swift
//  Staqo
//
//  Created by SHAILY on 01/04/21.
//

import UIKit

class TicketStatusVC: UIViewController {
    var header:HeaderView!
    @IBOutlet weak var herderView: HeaderView!

    @IBOutlet weak var closeDateTxt: UITextField!
    @IBOutlet weak var statusTxt: UITextField!
    @IBOutlet weak var taskDetailsTxtv: UITextView!
    @IBOutlet weak var locationtxt: UITextField!
    @IBOutlet weak var creationDateTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:100))
        header.delegate = self
       
        herderView.addSubview(header)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func statusSubmitButton(_ sender: Any) {
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
extension TicketStatusVC: HeaderViewDelegate{
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
