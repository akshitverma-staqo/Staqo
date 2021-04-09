//
//  RoomBTVC.swift
//  Staqo
//
//  Created by SHAILY on 24/03/21.
//

import UIKit
protocol RoomBTVCDelegate:class {
    func selectedTxtField(txtField:UITextField)
    func filledData(value:String)
    func showMsgValidation(msg:String)
    func getAllRooms(ID:String)
    func getArrangement(ID:String)
}

class RoomBTVC: UITableViewCell {
    var delegate:RoomBTVCDelegate?
    var _delegate:RoomBookingVCDelegate?
    var txtTag:Int = 0
    var vistorType : String = ""
    var recurringDay : String = ""
    var selectedIndex:Int = 0
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
    
    @IBOutlet weak var SatCheckTap: UIButton!
    @IBOutlet weak var FriCheckTap: UIButton!
    @IBOutlet weak var ThuCheckTap: UIButton!
    @IBOutlet weak var WedCheckTap: UIButton!
    @IBOutlet weak var MonCheckTap: UIButton!
    @IBOutlet weak var TueCheckTap: UIButton!
    @IBOutlet weak var SunCheckTap: UIButton!
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
    func dataBind(data:[RoomModel]?,roomData:[RoomType]? , locData:[Location]?,arrangData:[ArrangmentModel]?, picker:UIPickerView , viewDataPicker:UIView , delegateVC:RoomBookingVCDelegate?) {
        self.picker = picker
        self.viewPicker = viewDataPicker
        self.picker.delegate = self
        self.picker.dataSource = self
        rowsData = data
        self.rowsLoc = locData
        self.rowsRoom = roomData
        self.arrangModel = arrangData
       _delegate = delegateVC
        _delegate = self
    }
  
    
    @IBAction func roomSearchBtn(_ sender: Any) {
        
        if (locationTxt.text?.count ?? 0) <= 0 {
            delegate?.showMsgValidation(msg: "Please select the location")
        }else if( NumberVisitorTxt.text?.count ?? 0) <= 0 {
            delegate?.showMsgValidation(msg: "Please provide no of visitors ")
        }else if vistorType ==  "" {
            delegate?.showMsgValidation(msg: "Please select the Visitor Type")
        }
        else if (fromDateTxt.text?.count ?? 0) <= 0 {
            delegate?.showMsgValidation(msg: "Please select the From Date ")
        }
        else if (fromTimeTxt.text?.count ?? 0) <= 0 {
            delegate?.showMsgValidation(msg: "Please select the From Time  ")
        }
        else if (toDateTxt.text?.count ?? 0) <= 0 {
            delegate?.showMsgValidation(msg: "Please select the To Date  ")
        }
        else if (toTimeTxt.text?.count ?? 0) <= 0 {
            delegate?.showMsgValidation(msg: "Please select the To Time  ")
        }else if (roomTypeTxt.text?.count ?? 0) <= 0 {
            delegate?.showMsgValidation(msg: "Please select the Room Type  ")
        }
        else if (arrangmentTct.text?.count ?? 0) <= 0 && roomTypeTxt.text != "Audutorium"{
            delegate?.showMsgValidation(msg: "Please select the Arrangment Type")
        }
        else if (roomCodeTxt.text?.count ?? 0) <= 0 {
            delegate?.showMsgValidation(msg: "Please select the Room Code  ")
        }
        else{
            guard  let value = Helper.creatingRoomData(attendents: Int(NumberVisitorTxt.text ?? "0") ?? 0, fromDateTime: (fromDateTxt.text ?? "") + " " + (fromTimeTxt.text ?? ""), toDateTime: (toDateTxt.text ?? "") +  " " + (toTimeTxt.text ?? ""), remarks: purposeTxtView.text ?? "", visitorType: vistorType, roomType: roomTypeTxt.text ?? "", arrangementType: arrangmentTct.text ?? "", roomCode: roomCodeTxt.text ?? "", recurringDay: recurringDay)else {
                    return
                }
                do {
                let data = try JSONEncoder().encode(value)
                    let str = String(data: data, encoding:.utf8)
                    print(str)
                    delegate?.filledData(value: str ?? "")
                   
                }catch{
                    
                }
            
        }
        
    }
    @IBAction func BtnEmpCheck(_ sender: Any) {
        
        EmpCheckTap.setImage(UIImage(named: "check.png"), for: .normal)
        VisitorCheckTap.setImage(UIImage(named: "uncheckIcon.png"), for: .normal)
        VipCheckTap.setImage(UIImage(named: "uncheckIcon.png"), for: .normal)
        vistorType = "E"
    }
    
    @IBAction func BtnVisitorCheck(_ sender: Any) {
        
        EmpCheckTap.setImage(UIImage(named: "uncheckIcon.png"), for: .normal)
        VisitorCheckTap.setImage(UIImage(named: "check.png"), for: .normal)
        VipCheckTap.setImage(UIImage(named: "uncheckIcon.png"), for: .normal)
        vistorType = "V"
        
    }
    
    @IBAction func BtnVIPCheck(_ sender: Any) {
        
        EmpCheckTap.setImage(UIImage(named: "uncheckIcon.png"), for: .normal)
        VisitorCheckTap.setImage(UIImage(named: "uncheckIcon.png"), for: .normal)
        VipCheckTap.setImage(UIImage(named: "check.png"), for: .normal)
        vistorType = "I"
    }
    
    @IBAction func BtnSunCheck(_ sender: Any) {
    //Sun = 7
        if SunCheckTap.isSelected == true {
            
            SunCheckTap.isSelected = false
            recurringDay = recurringDay.replacingOccurrences(of: "7,", with: "")
            print(recurringDay)

          }else {
            recurringDay = recurringDay + "7,"
            SunCheckTap.isSelected = true
            print(recurringDay)
          }
        
    }
    
    @IBAction func BtnMonCheck(_ sender: Any) {
        //Mon = 1
        if MonCheckTap.isSelected == true {
            MonCheckTap.isSelected = false
            recurringDay = recurringDay.replacingOccurrences(of: "1,", with: "")
            print(recurringDay)

          }else {
            recurringDay = recurringDay + "1,"
            MonCheckTap.isSelected = true
            print(recurringDay)
          }
    }

    @IBAction func BtnTueCheck(_ sender: Any) {
        //Tue = 2
        if TueCheckTap.isSelected == true {
            TueCheckTap.isSelected = false
            recurringDay = recurringDay.replacingOccurrences(of: "2,", with: "")
            print(recurringDay)
        }else {
            recurringDay = recurringDay + "2,"
            TueCheckTap.isSelected = true
            print(recurringDay)
          }
    }
    
    @IBAction func BtnWenCheck(_ sender: Any) {
        //Wen = 3
        if WedCheckTap.isSelected == true {
            WedCheckTap.isSelected = false
            recurringDay = recurringDay.replacingOccurrences(of: "3,", with: "")
            print(recurringDay)


          }else {
            recurringDay = recurringDay + "3,"
            WedCheckTap.isSelected = true
            print(recurringDay)

          }
    }
    
    @IBAction func BtnThuCheck(_ sender: Any) {
        if ThuCheckTap.isSelected == true {
            ThuCheckTap.isSelected = false
            recurringDay = recurringDay.replacingOccurrences(of: "4,", with: "")
            print(recurringDay)


          }else {
            recurringDay = recurringDay + "4,"
            ThuCheckTap.isSelected = true
            print(recurringDay)

          }
    }
    
    @IBAction func BtnFriCheck(_ sender: Any) {
        if FriCheckTap.isSelected == true {
            FriCheckTap.isSelected = false
            recurringDay = recurringDay.replacingOccurrences(of: "5,", with: "")
            print(recurringDay)


          }else {
            recurringDay = recurringDay + "5,"
            FriCheckTap.isSelected = true
            print(recurringDay)

          }
    }
    
    @IBAction func BtnSatCheck(_ sender: Any) {
        if SatCheckTap.isSelected == true {
            SatCheckTap.isSelected = false
            recurringDay = recurringDay.replacingOccurrences(of: "6,", with: "")
            print(recurringDay)


          }else {
            recurringDay = recurringDay + "6,"
            SatCheckTap.isSelected = true
            print(recurringDay)

          }
    }
   @objc func dataSelection(){
    if txtTag == 3 {
        fromDateTxt.text = Constant.dateTimeFormatter(format: "MM-dd-yyyy", date: datePicker?.date ?? Date())
        
    }else if txtTag == 4 {
        fromTimeTxt.text = Constant.dateTimeFormatter(format: "HH:mm", date: datePicker?.date ?? Date())

    }else if txtTag == 5 {
        toDateTxt.text = Constant.dateTimeFormatter(format: "MM-dd-yyyy", date: datePicker?.date ?? Date())

    }else if txtTag == 6 {
        toTimeTxt.text = Constant.dateTimeFormatter(format: "HH:mm", date: datePicker?.date ?? Date())
    }
    
    }
}
//MARK:- Textfield Delegats
extension RoomBTVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if textField == NumberVisitorTxt {
        let set = NSCharacterSet(charactersIn: "0123456789").inverted
        let saparate = string.components(separatedBy: set)
        let numberFilter = saparate.joined(separator: "")
        return ((string == numberFilter ) && ((textString.count) <= 3))
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txtTag = textField.tag
        datePicker = UIDatePicker()
        datePicker?.addTarget(self, action: #selector(dataSelection), for: .valueChanged)
        if textField.tag == 3 {
            datePicker?.isHidden = false
            datePicker?.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePicker?.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
            datePicker?.minimumDate = Date()
            datePicker?.maximumDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())
            fromDateTxt.text = Constant.dateTimeFormatter(format: "MM-dd-yyyy", date: datePicker?.date ?? Date())
            textField.inputView = datePicker
            
        }else if textField.tag == 4 {
            datePicker?.isHidden = false
            datePicker?.datePickerMode = .time
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let min = dateFormatter.date(from: "9:00")
            let max = dateFormatter.date(from: "18:00")
            datePicker?.minimumDate = min
            datePicker?.maximumDate = max
            if #available(iOS 13.4, *) {
                datePicker?.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
            fromTimeTxt.text = Constant.dateTimeFormatter(format: "HH:mm", date: datePicker?.date ?? Date())
            textField.inputView = datePicker
        }else if  textField.tag == 5 {
            datePicker?.isHidden = false
            datePicker?.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePicker?.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
            
            let dateValue = Constant.stringToDate(format:"MM-dd-yyyy HH:mm", dateValue:fromDateTxt.text ?? "")
            datePicker?.minimumDate = Calendar.current.date(byAdding: .month, value: -1, to: dateValue ??  Date())
            datePicker?.maximumDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())
            toDateTxt.text = Constant.dateTimeFormatter(format: "MM-dd-yyyy", date: datePicker?.date ?? Date())
            textField.inputView = datePicker
            
            
            
            
            
            
            
        }else if textField.tag == 6 {
            datePicker?.isHidden = false
            datePicker?.datePickerMode = .time
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let min = dateFormatter.date(from: "9:00")
            let max = dateFormatter.date(from: "18:00")
            datePicker?.minimumDate = min
            datePicker?.maximumDate = max
            if #available(iOS 13.4, *) {
                datePicker?.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
            toTimeTxt.text = Constant.dateTimeFormatter(format: "HH:mm", date: datePicker?.date ?? Date())

            textField.inputView = datePicker
            
            
           
            
        }else if textField.tag == 2 {
            
        }
        else{
            
            if locationTxt.text == "" && txtTag == 9 {
                delegate?.showMsgValidation(msg: "Please select the location")
            }else if roomTypeTxt.text == "" && txtTag == 8{
                delegate?.showMsgValidation(msg: "Please select the Room Type  ")
            }
            else if txtTag == 1 {
                if rowsLoc?.count ?? 0 == 0   {
                    delegate?.showMsgValidation(msg: "Data not found")
                } else{
                    self.delegate?.selectedTxtField(txtField: textField)
                }
            } else if txtTag == 7 {
                if rowsRoom?.count ?? 0 == 0 {
                    delegate?.showMsgValidation(msg: "Data not found")
                } else{
                    self.delegate?.selectedTxtField(txtField: textField)
                }
            }
            
//            else if txtTag == 8 {
//                if arrangModel?.count ?? 0 == 0{
//                    delegate?.showMsgValidation(msg: "Data not found")
//                } else{
//                    self.delegate?.selectedTxtField(txtField: textField)
//                }
//
//            }
            else if txtTag == 9 {
                if rowsData?.count ?? 0 == 0 {
                    delegate?.showMsgValidation(msg: "Data not found")
                } else{
                    self.delegate?.selectedTxtField(txtField: textField)
                }
            }
           
               
        }
      
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if txtTag == 1 {
            if locationTxt.text != nil {
                delegate?.getAllRooms(ID: "\(rowsLoc?[selectedIndex].id ?? 0)")
            }
            
        }else if txtTag == 7 {
            if roomTypeTxt.text != nil {
                if  rowsRoom?[selectedIndex].id ?? 0 != 1 {
                    arrangmentTct.isEnabled = false
                }else{
                    arrangmentTct.isEnabled = true
                }
               
                delegate?.getArrangement(ID:"\(rowsRoom?[selectedIndex].id ?? 0)")
                arrangmentTct.text = nil
                arrangModel = []
            }
        }
    }
}
//MARK:- Picker view Delegats
extension RoomBTVC:UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if txtTag == 1{
        return rowsLoc?.count ?? 0
        }
        else if txtTag == 7 {
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
            selectedIndex = row
            locationTxt.text = rowsLoc?[row].locationName ?? ""
            return  rowsLoc?[row].locationName ?? ""
        }else if txtTag == 7 {
            selectedIndex = row
            roomTypeTxt.text = rowsRoom?[row].typeName ?? ""
            return rowsRoom?[row].typeName ?? ""
        }
        else if txtTag == 8 {
            selectedIndex = row
            arrangmentTct.text = arrangModel?[row].title ?? ""
            return arrangModel?[row].title ?? ""
        }
        else if txtTag == 9 {
            selectedIndex = row
            roomCodeTxt.text = rowsData?[row].roomCode ?? ""
            return rowsData?[row].roomCode ?? ""
            
        }
        else{
            return "vishnu"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if txtTag == 1{
            selectedIndex = row
            locationTxt.text = rowsLoc?[row].locationName ?? ""
        }else if txtTag == 7 {
            selectedIndex = row
            roomTypeTxt.text = rowsRoom?[row].typeName ?? ""
            disableArrangment()
        }else if txtTag == 8 {
            selectedIndex = row
            arrangmentTct.text = arrangModel?[row].title ?? ""
        }
        else if txtTag == 9 {
            selectedIndex = row
            roomCodeTxt.text = rowsData?[row].roomCode ?? ""
        }
        else{
            selectedIndex = row
            roomTypeTxt.text = "\(rowsData?[row].capacity ?? 0)"
        }
      
    }
    
    func disableArrangment()  {
        
        
        if roomTypeTxt.text == "Audutorium"{
            arrangmentTct.isEnabled = false
            arrangmentTct.text = ""
        }else{
            arrangmentTct.isEnabled = true

        }
        
        
        
    }
}
extension RoomBTVC : RoomBookingVCDelegate{
    func selectIndex() {
        
    }
}
