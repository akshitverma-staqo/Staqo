//
//  EmpVC.swift
//  Staqo
//
//  Created by SHAILY on 05/03/21.
//

import UIKit


class EmpVC: BaseVC {
    
    @IBOutlet weak var herderView: HeaderView!

    var header:HeaderView!
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
        
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:70))
        header.delegate = self
       
        herderView.addSubview(header)
        shadowView.dropShadow()
        viewModal = EmpViewModal(dataSource: EmpDataSource())
        viewModal.delegate = self
        //viewModal.empDelegate = self
        viewModal.empUpdateDelegate = self
        viewModal.bootstrap()
        innerView.layer.cornerRadius = 20
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        editProfileBackView.layer.cornerRadius = 11
        editProfileBackView.clipsToBounds = true
        
        phoneNoView.layer.cornerRadius = 10
        phoneNoView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        profileImageBackView.layer.cornerRadius = 10
        profileImageBackView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        self.submitBtnOutlet.isEnabled = false
        
        
        submitBtnbackView.dropShadow()
        
        
        submitBtnOutlet.layer.cornerRadius = 10
        submitBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        deleteBtnnumberView.dropShadow()
        
        
        deleteBtnOutlet.layer.cornerRadius = 10
        deleteBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        self.getImage()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        header.btnNotiyCount.setTitle("\(UserDefaults.standard.getNotifyCount() )", for: .normal)

        header.btnProfile .isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    func getImage(){
        
        if  let imageString = UserDefaults.standard.getProfileImage() {
      
            if let imageView = UIImage(data: imageString) {
                print("data contains image data")
                profileImage.image = imageView
             //   header.btnProfile.setImage(imageView, for: .normal)
            }
        }
    }
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        secNumber.resignFirstResponder()
        if (secNumber.text?.count) ?? 0 <= 9 {
            showErrorMessage(title: "Error..", error: CustomError.InValidNoLength) { (action) in
            }
        }else{
//            if viewModal.field?.mobileno2 ?? "" == secNumber.text{
//                showErrorMessage(title: "Alert", message: "Please update mobile number first.") { (action) in
//
//            }
//            }else{
                viewModal.updateByEmpID(mobileNo:secNumber.text! , ID: viewModal.valueData?.id ?? "")
           // }
           
            
        }
        
    }
    
    @IBAction func btnDeleteTapped(_ sender: UIButton) {

        if (secNumber.text?.count ?? 0) <= 0 {
            showErrorMessage(title: "Error..", message: "Number already Deleted") { (action) in
            }
        }else{
            showMessage(title: "", message: "Do you want to delete number?", btnConfirmTitle: "Yes", btnCancelTitle: "No") { (isYes, action) in
                if isYes{
                    self.viewModal.deleteEmp(ID: self.viewModal.field?.id ?? "")
                }
            }
           
        }
       
        
    }
    
}
extension EmpVC : ViewModelDelegate{
    func willLoadData() {
        startLoader()
    }
    
    func didLoadData() {
        stopLoader()

        view.endEditing(true)
        nameLabel.text = UserDefaults.standard.getProfile()?.name ?? ""
        jobTitleLabel.text = UserDefaults.standard.getProfile()?.jobTitle ?? ""
        empIdLabel.text = UserDefaults.standard.getProfile()?.employeeId ?? ""
        if ((UserDefaults.standard.getProfile()?.mobileNo1 ?? "") == "") || ((viewModal.field?.mobileno2 ?? "") == "") {
           
            mobile1Label.text = "\(UserDefaults.standard.getProfile()?.mobileNo1 ?? "") \( viewModal.field?.mobileno2 ?? "" )"

        }else{
            mobile1Label.text = "\(UserDefaults.standard.getProfile()?.mobileNo1 ?? "")" + ", " + "\( viewModal.field?.mobileno2 ?? "" )"
        }
        telephoneLabel.text = UserDefaults.standard.getProfile()?.businessPhone ?? ""
        addressLabel.text = viewModal.field?.emailid ?? ""
        secNumber.text = viewModal.field?.mobileno2 ?? ""
                
    }
    
    func didFail(error: CustomError) {
        
        showErrorMessage(title: "Error", error: error) { (action) in
            if error.localizedDescription.contains("401 Unauthorized") {
                print("401")
                self.showMessage(title: "", message: CustomError.Logout.localizedDescription, btnConfirmTitle:"YES", btnCancelTitle: "NO") { (isYes, action) in
                    if isYes {
                        let vc = Constant.getViewController(storyboard: Constant.kMainStoryboard, identifier: Constant.kLoginVC, type: LoginVC.self)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
           
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
extension EmpVC: HeaderViewDelegate{
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
extension EmpVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if textField == secNumber {
        let set = NSCharacterSet(charactersIn: "0123456789").inverted
        let saparate = string.components(separatedBy: set)
        let numberFilter = saparate.joined(separator: "")
        return ((string == numberFilter ) && ((textString.count) <= 10))
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == secNumber {
                self.viewModal.deleteEditEmp(ID: self.viewModal.field?.id ?? "")
                self.submitBtnOutlet.isEnabled = true
        }
        
    }
}
//extension EmpVC : EmpRefreshDelegate{
//    func getRefresh() {
//        showErrorMessage(title: "", message: "Phone Number deleted successfully") { (action) in
//            self.viewModal.bootstrap()
//        }
//    }
//}
extension EmpVC : EmpNoUpdateDelegate{
    func updateNo(status: String) {
        
        if status == "mobileupdate"{
            showErrorMessage(title: "", message: "Phone Number Submitted Successfully") { (action) in
                self.viewModal.bootstrap()
                self.submitBtnOutlet.isEnabled = false
            }
        }else if status == "mobiledeleted"{
            showErrorMessage(title: "", message: "Phone Number deleted successfully") { (action) in
                        self.viewModal.bootstrap()
                self.submitBtnOutlet.isEnabled = true
                    }
        }else if status == "mobiledeletedEdit"{
            print("mobile delete from backend")
        }
        
        
      
    }

}
