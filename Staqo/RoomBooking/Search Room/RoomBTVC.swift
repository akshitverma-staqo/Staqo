//
//  RoomBTVC.swift
//  Staqo
//
//  Created by SHAILY on 24/03/21.
//

import UIKit
protocol RoomBTVCDelegate:class {
    func selectedTxtField(txtField:UITextField)
}

class RoomBTVC: UITableViewCell {
    var delegate:RoomBTVCDelegate?
    var txtTag:Int = 0

    
    @IBOutlet weak var VipCheckTap: UIButton!
    @IBOutlet weak var VisitorCheckTap: UIButton!
    @IBOutlet weak var EmpCheckTap: UIButton!
    @IBOutlet weak var roomCodeTxt: UITextField!
    @IBOutlet weak var roomTypeTxt: UITextField!
    @IBOutlet weak var purposeTxtView: UITextView!
    @IBOutlet weak var toTimeTxt: UITextField!
    @IBOutlet weak var toDateTxt: UITextField!
    @IBOutlet weak var fromTimeTxt: UITextField!
    @IBOutlet weak var fromDateTxt: UITextField!
    @IBOutlet weak var locationTxt: UITextField!
    @IBOutlet weak var arrangmentTct: UITextField!
    
    @IBOutlet weak var NumberVisitorTxt: UITextField!
  
    @IBOutlet weak var capacityTxt: UITextField!
    var picker:UIPickerView!
    var viewPicker: UIView!
    var rowsData:[RoomModel]?
    var rowsRoom:[RoomType]?
    var rowsLoc:[Location]?
    var arrangModel:[ArrangmentModel]?
    var datePicker: UIDatePicker?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func dataBind(data:[RoomModel]?,roomData:[RoomType]? , locData:[Location]?,arrangData:[ArrangmentModel]?, picker:UIPickerView , viewDataPicker:UIView) {
        self.picker = picker
        self.viewPicker = viewDataPicker
        self.picker.delegate = self
        self.picker.dataSource = self
        rowsData = data
        self.rowsLoc = locData
        self.rowsRoom = roomData
        self.arrangModel = arrangData
    }
    @objc func doneBtnClicked(){
        
    }
    
    @IBAction func roomSearchBtn(_ sender: Any) {
        
    }
    @IBAction func BtnEmpCheck(_ sender: Any) {
    }
    
    @IBAction func BtnVisitorCheck(_ sender: Any) {
    }
    
    @IBAction func BtnVIPCheck(_ sender: Any) {
    }
    
    @IBAction func BtnSunCheck(_ sender: Any) {
    }
    
    @IBAction func BtnMonCheck(_ sender: Any) {
    }

    @IBAction func BtnTueCheck(_ sender: Any) {
    }
    
    @IBAction func BtnWenCheck(_ sender: Any) {
    }
    
    @IBAction func BtnThuCheck(_ sender: Any) {
    }
    
    @IBAction func BtnFriCheck(_ sender: Any) {
    }
    
    @IBAction func BtnSatCheck(_ sender: Any) {
    }
   @objc func dataSelection(){
        
    }
}
extension RoomBTVC: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txtTag = textField.tag
            self.delegate?.selectedTxtField(txtField: textField)
            picker.reloadAllComponents()
      
    }
}
extension RoomBTVC:UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if txtTag == 1{
        return rowsLoc?.count ?? 0
        }else if txtTag == 7 {
            return rowsRoom?.count ?? 0
        }else if txtTag == 8 {
            return arrangModel?.count ?? 0
        }
        else if txtTag == 9 {
             return rowsData?.count ?? 0
        }
        
        else{
           return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtTag == 1{
            return  rowsLoc?[row].locationName ?? ""
        }else if txtTag == 7 {
            return rowsRoom?[row].typeName ?? ""
        }
        else if txtTag == 8 {
            return arrangModel?[row].title ?? ""
        }
        else if txtTag == 9 {
            return rowsData?[row].roomCode ?? ""
            
        }
        else{
            return "vishnu"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if txtTag == 1{
            locationTxt.text = rowsLoc?[row].locationName ?? ""
        }else if txtTag == 7 {
            roomTypeTxt.text = rowsRoom?[row].typeName ?? ""
        }else if txtTag == 8 {
            arrangmentTct.text = arrangModel?[row].title ?? ""
        }
        else if txtTag == 9 {
            roomCodeTxt.text = rowsData?[row].roomCode ?? ""
        }
        else{
            roomTypeTxt.text = "\(rowsData?[row].capacity ?? 0)"
        }
      
    }
}
