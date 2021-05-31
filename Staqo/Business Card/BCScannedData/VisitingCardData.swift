//
//  VisitingCardData.swift
//  OQ
//
//  Created by Bennett University on 05/01/21.
//


import UIKit
import Vision
import NaturalLanguage
import Alamofire
import MSGraphClientModels
import Contacts



class VisitingCardData: BaseVC {
    
    var header:HeaderView!
    @IBOutlet weak var herderView: HeaderView!
    @IBOutlet weak var profileImage: UIImageView!
    var docData:[Entities]?
    var viewModel:VCDViewModel!
    @IBOutlet weak var submitBtnOutlet: UIButton!
    @IBOutlet weak var submitShadowView: UIView!
    @IBOutlet weak var noImageView: UIImageView!
    @IBOutlet weak var yesImageView: UIImageView!
    @IBOutlet weak var yesShadowView: UIView!
    @IBOutlet weak var noShadowView: UIView!
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentInnerView: UIView!
    @IBOutlet weak var commentShadowView: UIView!
    
    @IBOutlet weak var webSiteTextField: UITextField!
    @IBOutlet weak var webSiteInnerView: UIView!
    @IBOutlet weak var webSitshadowView: UIView!
    
    
    @IBOutlet weak var companyInnerView: UIView!
    @IBOutlet weak var companyShadowView: UIView!
    
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var addressInnerView: UIView!
    @IBOutlet weak var addressShadowView: UIView!
    
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var phoneInnerView: UIView!
    @IBOutlet weak var phoneShadowView: UIView!
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var emailInnerView: UIView!
    @IBOutlet weak var emailShadowView: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameInner: UIView!
    @IBOutlet weak var nameShadow: UIView!
    
    
    
    @IBOutlet weak var companyText: UITextField!
    
    
    var visitorEmailID = ""
    var accessToken = ""
    var scanby = ""
    var valueId = ""
    var isCheck: Bool = true{
        didSet{
            
            noImageView.tintColor = UIColor(red: 27.0/255, green: 173.0/255, blue: 185.0/255, alpha: 1.0)
            yesImageView.tintColor = UIColor(red: 27.0/255, green: 173.0/255, blue: 185.0/255, alpha: 1.0)
            if isCheck{
                yesImageView.image = UIImage(named: "check")?.withRenderingMode(.alwaysTemplate)
                noImageView.image = UIImage(named: "uncheckIcon")?.withRenderingMode(.alwaysTemplate)
            }
            else{
                noImageView.image = UIImage(named: "check")?.withRenderingMode(.alwaysTemplate)
                yesImageView.image = UIImage(named: "uncheckIcon")?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:70))
        header.delegate = self
        herderView.addSubview(header)
        
        nameShadow.dropShadow()
        nameInner.layer.cornerRadius = 10
        nameInner.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        emailShadowView.dropShadow()
        emailInnerView.layer.cornerRadius = 10
        emailInnerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        phoneShadowView.dropShadow()
        phoneInnerView.layer.cornerRadius = 10
        phoneInnerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        addressShadowView.dropShadow()
        addressInnerView.layer.cornerRadius = 10
        addressInnerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        companyShadowView.dropShadow()
        companyInnerView.layer.cornerRadius = 10
        companyInnerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        webSitshadowView.dropShadow()
        webSiteInnerView.layer.cornerRadius = 10
        webSiteInnerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        commentShadowView.dropShadow()
        commentInnerView.layer.cornerRadius = 10
        commentInnerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        yesShadowView.dropShadow()
        yesImageView.layer.cornerRadius = 5
        yesImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        noShadowView.dropShadow()
        noImageView.layer.cornerRadius = 5
        noImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        getImage()
        submitShadowView.dropShadow()
        submitBtnOutlet.layer.cornerRadius = 10
        submitBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        self.commentTextView.delegate = self
        self.nameTextField.delegate = self
        self.phoneTxtField.delegate = self
        self.webSiteTextField.delegate = self
        self.emailTxtField.delegate = self
        self.companyText.delegate = self
        self.addressTxtField?.delegate = self
        var addressString:String = ""
        docData?.forEach({ (value) in
            if value.category == "Phone Number"{
                self.phoneTxtField.text = value.text
            }else if value.category == "URL"{
                self.webSiteTextField.text = value.text

            }else if value.category == "Organization"{
                self.companyText.text = value.text

            }else if value.category == "Email"{
                self.emailTxtField.text = value.text

            }else if value.category == "Person"{
                self.nameTextField.text = value.text

            }else if value.category == "Address"{
                addressString =  addressString +  (value.text ?? "")

            }else if value.category == "Location"{
                addressString = addressString +  (value.text ?? "")

            }
    
    })
        
       
        self.addressTxtField.text = addressString

        
//        for  item in 0..< (docData?.count ?? 0) {
//
//        }
        

        self.commentTextView.placeholder = "Remark"
       
        
        scanby = "0"
        accessToken = UserDefaults.standard.string(forKey: "tokenResult1") ?? ""
        
        isCheck = true
        
        
        viewModel = VCDViewModel(dataSource: VCDDataSource())
        viewModel.delegate = self
//        GraphManager.instance.getMe {
//            (user: MSGraphUser?, error: Error?) in
//
//            DispatchQueue.main.async { [self] in
//                guard let currentUser = user, error == nil else {
//                    print("Error getting user: \(String(describing: error))")
//                    return
//                }
//
//                visitorEmailID = currentUser.mail ?? currentUser.userPrincipalName ?? ""
//                let headers: HTTPHeaders = [
//                    "Authorization": "Bearer "+accessToken+""
//                ]
//                let urlEmp = UserDefaults.standard.string(forKey: "EMPLOYEE_FOR_ID")
//                let urlStr = "\(String(describing: UserDefaults.standard.string(forKey: "BASE_URL")!))\(String(describing: UserDefaults.standard.string(forKey: "SITE_ID")!))\(String(describing: urlEmp!))\(visitorEmailID)'"
//                print("EMPLOYEE_FOR_ID" + urlStr)
//
//                //NetworkClient.request(url: urlStr, method: .get, parameters: nil, encoder: JSONEncoding.default, headers: headers)
////                AF.request(urlStr, encoding: JSONEncoding.default, headers: headers)
////                    .responseJSON { response in
////                        print(response)
////                        //to get status code
////
////                        if let data = response.data {
////                            do{
////                                let json = try JSON(data:data)
////                                //print(json)
////                                self.spinner.stop()
////
////                                valueId = json["value"][0]["id"].string ?? ""
////                                print(valueId)
////
////
////
////
////                            }catch let err{
////                                self.spinner.stop()
////
////                                print(err.localizedDescription)
////                            }
////
////
////
////                        }
////                    }
//
//
//
//            }
//
//
//
//        }
        
        
        
        
        
    }
    func getImage(){
        
        if  let imageString = UserDefaults.standard.getProfileImage() {
      
            if let imageView = UIImage(data: imageString) {
                print("data contains image data")
                //profileImage.image = imageView
                header.btnProfile.setImage(imageView, for: .normal)
            }
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        header.btnNotiyCount.setTitle("\(UserDefaults.standard.getNotifyCount() )", for: .normal)

        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func yesBtnAction(_ sender: UIButton) {
        isCheck = true
        scanby = "0"
    }
    @IBAction func noBtnAction(_ sender: UIButton) {
        isCheck = false
        scanby = "1"
        
    }
    @IBAction func backButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: Save contact
    
    func saveVCardContacts (vCard : Data) { // assuming you have alreade permission to acces contacts
        
        if #available(iOS 9.0, *) {
            
            let contactStore = CNContactStore()
            
            do {
                
                let saveRequest = CNSaveRequest() // create saveRequests
                
                let contacts = try CNContactVCardSerialization.contacts(with: vCard) // get contacts array from vCard
                
                for person in contacts{
                    
                    
                    let mutableContact = person.mutableCopy() as! CNMutableContact
                    //
                    saveRequest.add(mutableContact, toContainerWithIdentifier: nil)
                    
                    // create the alert
                    let alert = UIAlertController(title: "Add Contact", message: "Do you want to save Contact Details...", preferredStyle: UIAlertController.Style.alert)
                    
                    
                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { action in
                        DispatchQueue.main.async{
                            let mutableContact = person.mutableCopy() as! CNMutableContact
                            
                            saveRequest.add(mutableContact, toContainerWithIdentifier: nil)
                            print("person name1 ")
                        }
                        let alert = UIAlertController(title: "Add Contact", message: "Contact Save Successfully.", preferredStyle: UIAlertController.Style.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                            
                            self.dismiss(animated: true)
                            
                        }))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { action in
                        
                        self.dismiss(animated: true)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
                try contactStore.execute(saveRequest) // save to contacts
                
            } catch  {
                print("Unable to show the new contact") // something went wrong
            }
            
        }else{
            print("CNContact not supported.")
        }
    }
    // MARK: Check Duplicate Data
    
    func issValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "^[a-zA-Z][A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,4}$"
        let trimmedString = testStr.trimmingCharacters(in: .whitespaces)
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: trimmedString)
        return result
        
    }
    
    
    @IBAction func submitData(_ sender: Any) {
        
        
        
        if !issValidEmail(testStr: emailTxtField.text ?? "")
        {
            showErrorMessage(title: "Alert", message: "Email is not Valid") { (action) in
            
            }
        }else if (self.nameTextField.text?.count ?? 0) <= 0 {
            showErrorMessage(title: "Alert", message: "Name should not be blank") { (action) in
            
            }

        }
        else if (self.phoneTxtField.text?.count ?? 0) <= 9 {
            showErrorMessage(title: "Error..", error: CustomError.InValidNoLength) { (action) in
            }

        }
        
        else if !Constant.isValidWenUrl(url: self.webSiteTextField.text ?? "") {
            showErrorMessage(title: "Alert", message: "Please enter the valid Website") { (action) in
            
            }

        }
        else if (self.emailTxtField.text?.count ?? 0) <= 0 {
            showErrorMessage(title: "Alert", message: "Email Id should not be blank") { (action) in
            
            }

        }
        else if (self.companyText.text?.count ?? 0) <= 0 {
            showErrorMessage(title: "Alert", message: "Company should not be blank") { (action) in
            
            }

        }
        else if (self.addressTxtField.text?.count ?? 0) <= 0 {
            showErrorMessage(title: "Alert", message: "Address should not be blank") { (action) in
            
            }

        }else{
            
            viewModel.visitSaveData(email: emailTxtField.text ?? "", empID: Int( UserDefaults.standard.getEmpID()) ?? 0, name: nameTextField.text ?? "", cmpName: companyText.text ?? "", webSite: webSiteTextField.text ?? "", address: addressTxtField.text ?? "", mobileNo: phoneTxtField.text ?? "", remark: commentTextView.text ?? "", scanBy: scanby)
        }
    }

    // MARK: Save Contact Data on Server
    
    func setData(){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+accessToken+"",
            "Content-Type" : "application/json"
        ]
        let jsonreq: [String: Any]   = ["fields": ["Title":self.emailTxtField.text!,"emailid":self.emailTxtField.text!,"employeeidLookupId":self.valueId,"name":self.nameTextField.text!,"companyname":companyText.text!,"websitename":webSiteTextField.text!,"addressline1":addressTxtField.text!,"mobileno1":phoneTxtField.text!,"remarks":commentTextView.text!,"scanby":scanby]]
        
       
        let str = UserDefaults.standard.string(forKey: "VISITOR_REGISTER")
        let urlStr = "\(String(describing: UserDefaults.standard.string(forKey: "BASE_URL")!))\(String(describing: UserDefaults.standard.string(forKey: "SITE_ID")!))\(String(describing: str!))"
        
        // NetworkClient.request(url: urlStr, method: .post, parameters: jsonreq, encoder: JSONEncoding.prettyPrinted, headers: headers)
//        AF.request(urlStr, method: .post, parameters: jsonreq, encoding: JSONEncoding.prettyPrinted, headers: headers)
//            
//            .responseJSON { response in
//                print(response)
//                if let data = response.data {
//                    do{
//                        let json = try JSON(data:data)
//                        print("________")
//                        print(json)
//                        self.spinner.stop()
//                        self.openAlert1(title: "Alert",
//                                        message: "Data Save Successfully...",
//                                        alertStyle: .alert,
//                                        actionTitles: ["Ok"],
//                                        actionStyles: [.default],
//                                        actions: [
//                                            {_ in
//                                                self.dismiss(animated: true, completion: nil)
//                                                
//                                            }
//                                        ])
//                    }catch let err{
//                        print(err.localizedDescription)
//                        self.spinner.stop()
//                    }
//                }
//            }
    }
    
    

}

extension VisitingCardData: HeaderViewDelegate{
    func btnMenuTapped(sender: UIButton) {
        let vc =  Constant.getViewController(storyboard: Constant.kBusinessStoryboard, identifier: Constant.kBusinessVC, type: BusinessVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
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



extension VisitingCardData : UITextFieldDelegate{
    public override func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
extension VisitingCardData : ViewModelDelegate{
    func willLoadData() {
        startLoader()
    }
    
    func didLoadData() {
        stopLoader()
        showErrorMessage(title: "", error: CustomError.Saved) { (action) in
            let vc =  Constant.getViewController(storyboard: Constant.kBusinessStoryboard, identifier: Constant.kBusinessVC, type: BusinessVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    func didFail(error: CustomError) {
        stopLoader()
        showErrorMessage(title: "Error...", error: error) { (action) in
            
        }
    }
    
    
}
