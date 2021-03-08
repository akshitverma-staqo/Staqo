//
//  BusinessCardVC.swift
//  Staqo
//
//  Created by SHAILY on 06/03/21.
//

import UIKit

class BusinessCardVC: BaseVC {

    @IBOutlet weak var QRCodeImg: UIImageView!
    @IBOutlet weak var qrBtnShadowView: UIView!
    @IBOutlet weak var qrBtnWithConstrant: NSLayoutConstraint!
    @IBOutlet weak var qrCodeView: UIView!
    @IBOutlet weak var qrCodeBtnOutlet: UIButton!
    @IBOutlet weak var shareInnerView: UIView!
    @IBOutlet weak var shareShadowView: UIView!
    @IBOutlet weak var scanInnerView: UIView!
    @IBOutlet weak var scanShadowView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var shaddowView: UIView!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var telephoneText: UITextField!
    @IBOutlet weak var emailIDText: UITextField!
    var viewModal: BusinessCardViewModal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qrCodeView.isHidden = true
        shaddowView.dropShadow()
        qrBtnShadowView.dropShadow()
        scanShadowView.dropShadow()
        shareShadowView.dropShadow()
        scanInnerView.layer.cornerRadius = 16
        shareInnerView.layer.cornerRadius = 16
        
        innerView.layer.cornerRadius = 20
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        qrCodeView.layer.cornerRadius = 20
        qrCodeView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        qrCodeBtnOutlet.layer.cornerRadius = qrCodeBtnOutlet.frame.height / 2
        // Do any additional setup after loading the view.
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
extension BusinessCardVC: ViewModelDelegate{
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
