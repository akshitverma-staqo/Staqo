//
//  EmpVC.swift
//  Staqo
//
//  Created by SHAILY on 05/03/21.
//

import UIKit


class EmpVC: BaseVC {
    @IBOutlet weak var deleteBtnnumberView: UIView!
    @IBOutlet weak var deleteBtnOutlet: UIButton!
    @IBOutlet weak var submitBtnOutlet: UIButton!
    @IBOutlet weak var submitBtnbackView: UIView!
    @IBOutlet weak var profileImageBackView: UIView!
    @IBOutlet weak var phoneNoView: UIView!
    @IBOutlet weak var editProfileBackView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var empIdLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var mobile1Label: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var secNumber: UITextField!
    
    
    var viewModal: EmpViewModal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.dropShadow()
        viewModal = EmpViewModal(dataSource: EmpDataSource())
        viewModal.delegate = self
        viewModal.bootstrap()
        innerView.layer.cornerRadius = 20
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        editProfileBackView.layer.cornerRadius = 11
        editProfileBackView.clipsToBounds = true
        
        phoneNoView.layer.cornerRadius = 10
        phoneNoView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        profileImageBackView.layer.cornerRadius = 10
        profileImageBackView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        
        
        
        submitBtnbackView.dropShadow()
        
        
        submitBtnOutlet.layer.cornerRadius = 10
        submitBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        deleteBtnnumberView.dropShadow()
        
        
        deleteBtnOutlet.layer.cornerRadius = 10
        deleteBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        // Do any additional setup after loading the view.
        
    }
    

    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        if (secNumber.text?.count) ?? 0 <= 9 {
            showErrorMessage(title: "Error..", error: CustomError.InValidNoLength) { (action) in
            }
        }else{
            viewModal.updateByEmpID(mobileNo:secNumber.text! , ID: viewModal.valueData?.id ?? "")
        }
        
    }
    
    @IBAction func btnDeleteTapped(_ sender: UIButton) {
    }
    
}
extension EmpVC : ViewModelDelegate{
    func willLoadData() {
        startLoader()
    }
    
    func didLoadData() {
        stopLoader()
         nameLabel.text = viewModal.field?.name ?? ""
         empIdLabel.text = (viewModal.field?.emailid ?? "").replacingOccurrences(of: "@oq.com", with: "")
        mobile1Label.text = "\(UserDefaults.standard.getProfile()?.mobileNo1 ?? "") \( viewModal.field?.mobileno2 ?? "" )"
        telephoneLabel.text = UserDefaults.standard.getProfile()?.businessPhone ?? ""
        addressLabel.text = viewModal.field?.emailid ?? ""
        secNumber.text = viewModal.field?.mobileno2 ?? ""
                
    }
    
    func didFail(error: CustomError) {
        showErrorMessage(title: "Error", error: error) { (action) in
            
        }
        stopLoader()
    }
    
    
}
extension UIView{
    func dropShadow(scale: Bool = true, cornerRadius: CGFloat = 0) {
        
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
    }
    func dropShadowHome(scale: Bool = true, cornerRadius: CGFloat = 0) {
        
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10.0
    }
    
    func cornerRadiusAndBorder(scale: Bool = true, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor){
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}
