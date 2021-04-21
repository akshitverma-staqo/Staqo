//
//  BusinessCardVC.swift
//  Staqo
//
//  Created by SHAILY on 06/03/21.
//

import UIKit

class BusinessCardVC: BaseVC {
    var header:HeaderView!
    @IBOutlet weak var herderView: HeaderView!
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
    
    @IBOutlet weak var mobileLbl: UITextField!
    @IBOutlet weak var businessPhoneLbl: UITextField!
    @IBOutlet weak var addressTextView: UITextView!

    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var emailIDText: UITextField!
    var viewModal: EmpViewModal!
    var isFlip: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:70))
        header.delegate = self
        herderView.addSubview(header)
        
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
        
        viewModal = EmpViewModal(dataSource: EmpDataSource())
        viewModal.delegate = self
        viewModal.bootstrap()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        header.btnNotiyCount.setTitle("\(UserDefaults.standard.getNotifyCount() )", for: .normal)

        self.navigationController?.isNavigationBarHidden = true
    }
    
    func generateQRCodef(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        print(data as Any)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }

    
    @IBAction func shareButton(_ sender: Any) {
        
        if isFlip{
            let activityViewController = UIActivityViewController(activityItems: [self.QRCodeImg.image!], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }else{
            let renderer = UIGraphicsImageRenderer(size: innerView.bounds.size)
            let businessCardimage = renderer.image { ctx in
                shaddowView.drawHierarchy(in: innerView.bounds, afterScreenUpdates: true)
            }
            let activityViewController = UIActivityViewController(activityItems: [businessCardimage], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func flipViewAction(_ sender: Any) {
        if isFlip{
            isFlip = false
            UIView.transition(with: shaddowView, duration: 0.8, options: [.transitionFlipFromRight], animations: {
                self.shaddowView.isHidden = false
                self.qrCodeView.isHidden = true
            }, completion: nil)
            self.qrCodeBtnOutlet.setTitle("Show QR Code", for: .normal)
            self.qrBtnWithConstrant.constant = 118
        }else{
            isFlip = true
            UIView.transition(with: qrCodeView, duration: 0.8, options: [.transitionFlipFromLeft], animations: {
                self.shaddowView.isHidden = true
                self.qrCodeView.isHidden = false
            }, completion: nil)
            self.qrCodeBtnOutlet.setTitle("Show Business Card", for: .normal)
            self.qrBtnWithConstrant.constant = 148
          
                if (UserDefaults.standard.getProfile()?.mobileNo1 ?? "" != "") {
                    self.generateQRCode(mobileNo: UserDefaults.standard.getProfile()?.mobileNo1 ?? "")
                }
                
                else if (viewModal.field?.mobileno2 ?? "" != ""){
                    self.generateQRCode(mobileNo:viewModal.field?.mobileno2 ?? "")
                }else if (UserDefaults.standard.getProfile()?.businessPhone ?? "" != "" ){
                    self.generateQRCode(mobileNo: UserDefaults.standard.getProfile()?.businessPhone ?? "")
                }
            else{
                showErrorMessage(title: "Error", error: CustomError.QrCodeGenerated) { (action) in
                }
            }
            print("the qrcode is show..")
        }
    }
    
    
    @IBAction func btnScanTapped(_ sender: Any) {
        
        
        
        let vc = Constant.getViewController(storyboard: Constant.kBusinessStoryboard, identifier: Constant.kScanQRViewController, type: ScanQRViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    func generateQRCode(mobileNo:String) {
        self.QRCodeImg.image = self.generateQRCodef(from: "BEGIN:VCARD \n" +
                                                        "VERSION:3.0 \n" +
                                                        "FN:\(nameLabel.text ?? "") \n" +
                                                        "N:\(nameLabel.text ?? "") \n" +
                                                        "TEL;CELL:\(businessPhoneLbl.text ?? "" ) \n" +
                                                        "TEL;WORK;VOICE: \((UserDefaults.standard.getProfile()?.mobileNo1 ?? "")) \n" +
                                                        "EMAIL;WORK;INTERNET:\(addressTextView.text ?? "") \n" +
                                                        
                                                        "END:VCARD")
        
        print("mob1 is available")
    }
   

}
extension BusinessCardVC: ViewModelDelegate{
    func willLoadData() {
        startLoader()

    }
    
    func didLoadData() {
        
        stopLoader()
        nameLabel.text = viewModal.field?.name ?? ""
        mobileLbl.text = "\(UserDefaults.standard.getProfile()?.mobileNo1 ?? "") \( viewModal.field?.mobileno2 ?? "" )"
        businessPhoneLbl.text = UserDefaults.standard.getProfile()?.businessPhone ?? ""
        addressTextView.text = viewModal.field?.emailid ?? ""
        
        
    }
    
    func didFail(error: CustomError) {
        showErrorMessage(title: "Error", error: error) { (action) in
            
        }
        stopLoader()
    }
    
    
}
extension BusinessCardVC: HeaderViewDelegate{
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
