//
//  HelpTVC.swift
//  Staqo
//
//  Created by SHAILY on 01/04/21.
//

import UIKit
protocol LogTicketTCVDelegate:class {
    func showMsgValidation(msg:String)
    func getSubCat(ID:String)
    func submitRequest(desc:String , subj:String , catID:String , prioName:String , subID:String)
    func uploadImage(file:Data , ID:String)
}
class LogTicketTVC: UITableViewCell, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var priorityTxt: UITextField!
    @IBOutlet weak var companyTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var subCatTxt: UITextField!
    @IBOutlet weak var categoryTxt: UITextField!
    @IBOutlet weak var attachmentLbl: UILabel!
    @IBOutlet weak var subjectTxt: UITextField!
    var delegate:LogTicketTCVDelegate?
    private lazy var imagePicker = ImagePicker()
    var catData:[Categories]?
    var subCatData:[Subcategories]?
    var priorityArray = ["Low","Medium","High"]
    var companyArray = ["OQ","IThink"]
    var txtTag:Int = 0
    var subCount: Int = 0
    var selectedIndex:Int = 0
    var picker:UIPickerView!
    var vc:LogTicketVC?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        picker = UIPickerView()
        self.picker.delegate = self
        self.picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.translatesAutoresizingMaskIntoConstraints = false
        imagePicker.delegate = self
       // self.addSubview(picker)

        

        
    }
    @IBAction func attachmentTap(_ sender: UIButton) {
       
        imagePicker.present(parent: vc! , sourceType: UIImagePickerController.SourceType.photoLibrary, sender: sender)
       
        
    }
    @IBAction func btnSubmitTap(_ sender: Any) {
        
        if (subjectTxt.text?.count ?? 0) <= 0 {
            delegate?.showMsgValidation(msg: "Please enter Subject")
        }else if( categoryTxt.text?.count ?? 0) <= 0 {
            delegate?.showMsgValidation(msg: "Please select the Category")
        }else if subCatTxt.text ==  "" {
            delegate?.showMsgValidation(msg: "Please select the Subcategory")
        }
//        else if (attachmentLbl.text?.count ?? 0) <= 0 {
//            delegate?.showMsgValidation(msg: "Please select the Attachment")
//        }
        else if (companyTxt.text?.count ?? 0) <= 0 {
            delegate?.showMsgValidation(msg: "Please select the Company")
        }
        else if (priorityTxt.text?.count ?? 0) <= 0 {
            delegate?.showMsgValidation(msg: "Please select the Priority")
        }
      
        else{
           
  //          print(subCatData?[selectedIndex].id ?? "")
            delegate?.submitRequest(desc: descriptionTxt.text ?? "", subj: subjectTxt.text ?? "", catID: "8", prioName: priorityTxt.text ?? "", subID: subCatData?[selectedIndex].id ?? "")
            
        }
        
        
    }

    func dataBind(data:[Categories]?, index:IndexPath, vc:LogTicketVC) {
        catData = data
        self.vc = vc
    }
    func dataBind1(dataSubCat:[Subcategories]?, index:IndexPath) {
        subCatData = dataSubCat
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
              // Configure the view for the selected state
    }
    @objc func doneBtnClicked(){
       // delegate?.selectIndex()
    }
}


// MARK:- Picker view Delegates
extension LogTicketTVC : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if txtTag == 1{

            return 0
        }
        else if txtTag == 2 {
            return catData?.count ?? 0
            
        }else if txtTag == 3 {
            return subCatData?.count ?? 0
        }
        else if txtTag == 4 {
            return companyArray.count
        }
        else if txtTag == 5 {
            return priorityArray.count
        }
        
        else{
           return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if txtTag == 1{
            
            return ""
           
        }else if txtTag == 2 {
            selectedIndex = row
            categoryTxt.text = catData?[row].name ?? ""
            return catData?[row].name ?? ""
            
        }
        else if txtTag == 3 {
            selectedIndex = row
            subCatTxt.text = subCatData?[row].name ?? ""
            return subCatData?[row].name ?? ""
            
        }
        else if txtTag == 4 {
            selectedIndex = row
            companyTxt.text = companyArray[row]
            return companyArray[row]
            
        }
        else if txtTag == 5 {
            selectedIndex = row
            priorityTxt.text = priorityArray[row]
            return priorityArray[row]
            
        }
        else{
            return "vishnu"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       // picker.selectRow(row, inComponent: 0, animated: true)

        if txtTag == 1{
         //   selectedIndex = row
            
        }else if txtTag == 2 {
            selectedIndex = row
            categoryTxt.text = catData?[row].name ?? ""
            print("didSelectRow" + "\(selectedIndex)")

            
        }else if txtTag == 3 {
            
            selectedIndex = row
            subCount = row
            subCatTxt.text = subCatData?[row].name ?? ""
            print(selectedIndex)
            print(subCatData?[row].name ?? "")
           
        }
        else if txtTag == 4 {
          //  selectedIndex = row
            companyTxt.text = companyArray[row]
        }
        else if txtTag == 5{
         //   selectedIndex = row
            priorityTxt.text = priorityArray[row]
        }else {
            
        }


      
    }
    
    
}

// MARK: - TextField Delegate

extension LogTicketTVC : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         txtTag = textField.tag
        if txtTag == 1{
            categoryTxt.inputView = keyboardToolbar
        }
        if txtTag == 2{
            categoryTxt.inputView = picker
            picker.reloadAllComponents()
        }else if txtTag == 3{
            if subCount == 0{
                subCount = +1
                print("Hello count" + "\(subCount)")
                picker.selectRow(0, inComponent: 0, animated: false)
            }else{
                picker.selectRow(subCount, inComponent: 0, animated: false)
            }
            

            subCatTxt.inputView = picker
            picker.reloadAllComponents()
        }
        else if txtTag == 4{
            companyTxt.inputView = picker
            picker.reloadAllComponents()
        }
        else if txtTag == 5{
            priorityTxt.inputView = picker
            picker.reloadAllComponents()
        }else{
            
            
        }
     
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
       
       if txtTag == 2{
            if categoryTxt.text != nil {
                delegate?.getSubCat(ID: catData?[selectedIndex].id ?? "")
            }
        }
    }
}
       
extension LogTicketTVC :ImagePickerDelegate{
    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        
    }
    
    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        
    }
    
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker, imageName: String, btn: UIButton) {
        if let data:Data = image.pngData() {
            delegate?.uploadImage(file: data, ID: "238")
            attachmentLbl.text = imageName
        }
               let root = UIApplication.shared.keyWindow?.rootViewController
               root?.dismiss(animated: true, completion: nil)
                
    }
    
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) {
        let root = UIApplication.shared.keyWindow?.rootViewController
        root?.dismiss(animated: true, completion: nil)
    }
    
    
}
