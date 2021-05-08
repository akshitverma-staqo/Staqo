//
//  RoomBTVC.swift
//  Staqo
//
//  Created by SHAILY on 24/03/21.
//

import UIKit
enum WeekDays:Int {
    case Sun = 1
    case Mon
    case Tue
    case Wed
    case Thu
    case Fri
    case Sat
}
protocol RoomBTVCDelegate:class {
    func selectedTxtField(txtField:UITextField)
    func filledData(value:String)
    func showMsgValidation(msg:String)
    func getAllRooms(ID:String)
    func getArrangement(ID:String)
    func reloadTableData()
}

class RoomBTVC: UITableViewCell {
    @IBOutlet weak var recurringMeetingView: UIView!
    var delegate:RoomBTVCDelegate?
    var _delegate:RoomBookingVCDelegate?
    var txtTag:Int = 0
    var vistorType : String = ""
    var recurringDay : String = ""
    var selectedIndex:Int = 0
    @IBOutlet weak var arrangmentImageView: UIImageView!
    @IBOutlet weak var arrangeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var arrangmentView: UIView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var arrangmentTypeLbl: UILabel!
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
    @IBOutlet weak var arrangeView: UIView!
    @IBOutlet weak var arrangeConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var roomLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var arrangeLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var arrangLbl: UILabel!
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
    var roomDataFilter:[RoomModel]?
    var rowsRoom:[RoomType]?
    var rowsLoc:[Location]?
    var locIndex:Int = 0
    var arrangModel:[ArrangmentModel]?
    var datePicker: UIDatePicker?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        purposeTxtView.layer.cornerRadius = 8
        purposeTxtView.placeholder = "Write your purpose here"
       arrangeViewHeight.constant = 0
        
        if (fromDateTxt.text?.count ?? 0) <= 0 {
            fromDateTxt.text = Constant.dateTimeFormatter(format: "dd-MM-yyyy", date: datePicker?.date ?? Date())

        }
        if fromTimeTxt.text?.count ?? 0 <= 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let min = dateFormatter.date(from: "9:00")
            fromTimeTxt.text = Constant.dateTimeFormatter(format: "HH:mm", date: min ?? Date())
            //fromTimeTxt.text = Constant.dateTimeFormatter(format: "HH:mm", date: datePicker?.date ?? Date())
        }
        if toTimeTxt.text?.count ?? 0 <= 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let min = dateFormatter.date(from: "18:00")
            toTimeTxt.text = Constant.dateTimeFormatter(format: "HH:mm", date: min ?? Date())
            
        }
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
        self.rowsData = data
        
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
            delegate?.showMsgValidation(msg: "Please provide no of Attendees ")
        }else if vistorType ==  "" {
            delegate?.showMsgValidation(msg: "Please select the Attendees Type")
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
        }
        else if (purposeTxtView.text.count) <= 0 {
            delegate?.showMsgValidation(msg: "Please Provide the purpose")
        }
        //else if (roomTypeTxt.text?.count ?? 0) <= 0 {
//            delegate?.showMsgValidation(msg: "Please select the Room Type  ")
//        }
//        else if (arrangmentTct.text?.count ?? 0) <= 0 && roomTypeTxt.text != "Audutorium"{
//            delegate?.showMsgValidation(msg: "Please select the Arrangment Type")
//        }
//        else if (roomCodeTxt.text?.count ?? 0) <= 0 {
//            delegate?.showMsgValidation(msg: "Please select the Room Code  ")
//        }
        else{
            guard  let value = Helper.creatingRoomData(locID:rowsLoc?[locIndex].id ?? 0 , attendents: Int(NumberVisitorTxt.text ?? "0") ?? 0, fromDateTime: (fromDateTxt.text ?? "") + " " + (fromTimeTxt.text ?? ""), toDateTime: (toDateTxt.text ?? "") +  " " + (toTimeTxt.text ?? ""), remarks: purposeTxtView.text ?? "", visitorType: vistorType, roomType: roomTypeTxt.text ?? "", arrangementType: arrangmentTct.text ?? "", roomCode: roomCodeTxt.text ?? "", recurringDay: recurringDay)else {
                    return
                }
                do {
                let data = try JSONEncoder().encode(value)
                    let str = String(data: data, encoding:.utf8)
                    print(str ?? "")
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
    
    func checkWeekStatus(index:Int , value:Bool){
        switch WeekDays(rawValue: index) {
        case .Sun:
            recurringDay = recurringDay + "7,"
            SunCheckTap.isEnabled = value
            SunCheckTap.isSelected = value
        case .Mon:
            recurringDay = recurringDay + "1,"
            MonCheckTap.isEnabled = value
            MonCheckTap.isSelected = value
        case .Tue:
            recurringDay = recurringDay + "2,"
            TueCheckTap.isEnabled = value
            TueCheckTap.isSelected = value
        case .Wed:
            recurringDay = recurringDay + "3,"
            WedCheckTap.isEnabled = value
            WedCheckTap.isSelected = value
        case .Thu:
            recurringDay = recurringDay + "4,"
            ThuCheckTap.isEnabled = value
            ThuCheckTap.isSelected = value
        case .Fri:
            recurringDay = recurringDay + "5,"
            FriCheckTap.isEnabled = value
            FriCheckTap.isSelected = value
        case .Sat:
            recurringDay = recurringDay + "6,"
            SatCheckTap.isEnabled = value
            SatCheckTap.isSelected = value
        default:
            break
        }
    }
    func btnEnable(enable:Bool, select:Bool){
        SunCheckTap.isEnabled = enable
        SunCheckTap.isSelected = select
        MonCheckTap.isEnabled = enable
        MonCheckTap.isSelected = select
        TueCheckTap.isEnabled = enable
        TueCheckTap.isSelected = select
        WedCheckTap.isEnabled = enable
        WedCheckTap.isSelected = select
        ThuCheckTap.isEnabled = enable
        ThuCheckTap.isSelected = select
        FriCheckTap.isEnabled = enable
        FriCheckTap.isSelected = select
        SatCheckTap.isEnabled = enable
        SatCheckTap.isSelected = select
        recurringDay = ""

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
        fromDateTxt.text = Constant.dateTimeFormatter(format: "dd-MM-yyyy", date: datePicker?.date ?? Date())
        
    }else if txtTag == 4 {
        fromTimeTxt.text = Constant.dateTimeFormatter(format: "HH:mm", date: datePicker?.date ?? Date())

    }else if txtTag == 5 {
        toDateTxt.text = Constant.dateTimeFormatter(format: "dd-MM-yyyy", date: datePicker?.date ?? Date())

    }else if txtTag == 6 {
        toTimeTxt.text = Constant.dateTimeFormatter(format: "HH:mm", date: datePicker?.date ?? Date())
    }
    
    }
    
    func getLtype(){
       
//DispatchQueue.main.async {
            if  self.arrangModel != nil {
                self.arrangeViewHeight.constant = 124
                self.arrangmentView.isHidden = false
                arrangmentImageView.isHidden = false
                self.contentView.needsUpdateConstraints()
                self.contentView.setNeedsLayout()
                let url = URL(string: self.arrangModel?[self.selectedIndex].webUrl ?? "")!

               // Fetch Image Data
               if let data = try? Data(contentsOf: url) {
                   // Create Image and Update Image View
                self.arrangmentImageView.image = UIImage(data: data)

               }
                self.delegate?.reloadTableData()
        }

  //      }
        

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
            if (fromDateTxt.text?.count ?? 0) <= 0 {
                fromDateTxt.text = Constant.dateTimeFormatter(format: "dd-MM-yyyy", date: datePicker?.date ?? Date())

            }
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
            if fromTimeTxt.text?.count ?? 0 <= 0 {
                fromTimeTxt.text = Constant.dateTimeFormatter(format: "HH:mm", date: datePicker?.date ?? Date())
                
            }
            textField.inputView = datePicker
        }else if  textField.tag == 5 {
            datePicker?.isHidden = false
            datePicker?.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePicker?.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
            
            let dateValue = Constant.stringToDate(format:"dd-MM-yyyy HH:mm", dateValue:fromDateTxt.text ?? "")
            datePicker?.minimumDate = Calendar.current.date(byAdding: .month, value: -1, to: dateValue ??  Date())
            datePicker?.maximumDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())
            if (toDateTxt.text?.count ?? 0) <= 0{
                toDateTxt.text = Constant.dateTimeFormatter(format: "dd-MM-yyyy", date: datePicker?.date ?? Date())

            }
            textField.inputView = datePicker
            
            
            
            
            
            
            
        }else if textField.tag == 6 {
            datePicker?.isHidden = false
            datePicker?.datePickerMode = .time
            var dateComp = Calendar.current.dateComponents([.day, .month , .year], from: Date())
            dateComp.setValue(9, for: .hour)
            let min = Calendar.current.date(from: dateComp)
            dateComp.setValue(18, for: .hour)
            let max = Calendar.current.date(from: dateComp)
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "HH:mm"
//            let min = dateFormatter.date(from: "9:00")
//            let max = dateFormatter.date(from: "9:00")
           datePicker?.minimumDate = min
            datePicker?.maximumDate = max
            if #available(iOS 13.4, *) {
                datePicker?.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
            if (toTimeTxt.text?.count ?? 0) <= 0 {
            toTimeTxt.text = Constant.dateTimeFormatter(format: "HH:mm", date: datePicker?.date ?? Date())
            }
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
            
            else if txtTag == 8 {
                if arrangModel?.count ?? 0 == 0{
                    delegate?.showMsgValidation(msg: "Data not found")
                } else{
                    self.delegate?.selectedTxtField(txtField: textField)
                }

            }
            else if txtTag == 9 {
                if roomTypeTxt.text?.count ?? 0 <= 0{
                   roomDataFilter =  rowsData
                    if roomDataFilter?.count ?? 0 == 0 {
                       delegate?.showMsgValidation(msg: "Data not found")
                   }else{
                    
                    self.delegate?.selectedTxtField(txtField: textField)
                }
                }else if roomDataFilter?.count ?? 0 == 0 {
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
        }
        else if txtTag == 3{
            toDateTxt.text  = nil
        }
        
        else if txtTag == 5 {
           print("Check Date")
            if fromDateTxt.text == "" {
                delegate?.showMsgValidation(msg: "Please select first From Date.")
            }else{
                
              
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let firstDate = formatter.date(from: fromDateTxt.text ?? "")
                let secondDate = formatter.date(from: toDateTxt.text ?? "")
                var dayComp = DateComponents()

                
                if firstDate?.compare(secondDate!) == .orderedAscending || firstDate?.compare(secondDate!) == .orderedSame {
                    print("First Date is smaller then second date")
                    //recurringMeetingView.isHidden = false
                    if let dates = firstDate {
                        let day = secondDate?.days(from: dates)
                        print(day ?? 0)
                        if day ?? 0 <= 7{
                           btnEnable(enable: false, select: false)
                            let weekCounter = (day ?? 0) + 1
                           
                            for item in 0..<weekCounter {
                                dayComp.day = item
                                let nextDate = Calendar.current.date(byAdding: dayComp, to: firstDate ?? Date())
                                let weekDaysStart = Calendar.current.component(.weekday, from: nextDate ?? Date())
                                print(weekDaysStart)
                                checkWeekStatus(index: weekDaysStart, value: true)
                                
                            }
                           // btnEnable(value: false)
                            print("day less than 7")
 
                         
                        }else{
                        //    recurringMeetingView.isHidden = false
                            
                            btnEnable(enable: true, select: false)
                            print("day more than saven and 7")
                        }
                            
                    }
                   

                }else if firstDate?.compare(secondDate!) == .orderedDescending{
                    print("First Date is greater then second date")
                    delegate?.showMsgValidation(msg: "Please select Date in Correct Order")
                    toDateTxt.text = ""
                 
                    
                }
            }
            
        }
        
        else if txtTag == 4{
      
        } else if txtTag == 6{
        
               print("Check Time")

                
                if fromDateTxt.text == "" {
                    delegate?.showMsgValidation(msg: "Please select first From Time.")

                    
                }else{
                    
                  
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    let firstDate = formatter.date(from: fromTimeTxt.text ?? "")
                    let secondDate = formatter.date(from: toTimeTxt.text ?? "")
                    
                    
                    if firstDate?.compare(secondDate!) == .orderedAscending {
                        print("First time is smaller then second time")
 
                    }else if firstDate?.compare(secondDate!) == .orderedDescending{
                        print("First time is greater then second time")
                        delegate?.showMsgValidation(msg: "Please select Time in Correct Order")
                        toTimeTxt.text = ""
                        fromTimeTxt.text = ""
                     

                    }else{
//                        let firstDate = formatter.date(from: fromDateTxt.text ?? "")
//                        let secondDate = formatter.date(from: toDateTxt.text ?? "")
                        
                        print("Both dates are same")
                        toTimeTxt.text = ""
                        fromTimeTxt.text = ""
                        delegate?.showMsgValidation(msg: "Both Time are Same Please choose different time SLOT.")
                        
    //                    let day = Calendar.current.component(.weekday, from: Date())
                      
                                            
                    }
                }
               
                
           
        }
        
        
        else if txtTag == 7 {
            if roomTypeTxt.text != nil {
                
                self.roomDataFilter  = self.rowsData?.filter{$0.roomtypeid == "\(rowsRoom?[selectedIndex].id ?? 0)"}
                roomCodeTxt.text = nil
                if  rowsRoom?[selectedIndex].id ?? 0 == 1 {
                    arrangmentTct.isEnabled = true
                    arrangeConstraint.constant = 40
                    arrangeLeadingConstraint.constant = 20
                    roomLeadingConstraint.constant = 20
                    arrangLbl.isHidden = false
                    arrangLbl.text = "Arrangment Type"
                    arrangeView.isHidden = false
                    self.arrangeViewHeight.constant = 0
                    arrangmentImageView.isHidden = true
                  
                    delegate?.getArrangement(ID:"\(rowsRoom?[selectedIndex].id ?? 0)")
                }else{
                    arrangeConstraint.constant = 0
                    arrangeLeadingConstraint.constant = 0
                    roomLeadingConstraint.constant = 0
                    arrangLbl.text = nil
                    arrangeView.isHidden = true
                    //arrangmentTypeLable.isHidden = true
                    arrangmentImageView.isHidden = true

                    arrangLbl.isHidden = true
                    arrangeViewHeight.constant = 0
                    arrangmentView.isHidden = true
                    arrangmentTct.text = nil
                    arrangModel = []
                   
                    arrangmentTct.isEnabled = false
                    delegate?.reloadTableData()
                }
               
               
            }else{
                self.roomDataFilter = self.rowsData
            }
        }else if txtTag == 8 {
        self.getLtype()
            
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
             return roomDataFilter?.count ?? 0
        }
        
        else{
           return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtTag == 1{
            locIndex = row
            locationTxt.text = rowsLoc?[row].locationName ?? ""
            return  rowsLoc?[row].locationName ?? ""
        }else if txtTag == 7 {
            selectedIndex = row
            roomTypeTxt.text = rowsRoom?[row].typeName ?? ""
            return rowsRoom?[row].typeName ?? ""
        }
        else if txtTag == 8 {
            selectedIndex = row
            arrangmentTct.text = arrangModel?[row].pattern_x002f_Design ?? ""
            return arrangModel?[row].pattern_x002f_Design ?? ""
        }
        else if txtTag == 9 {
            selectedIndex = row
            roomCodeTxt.text = roomDataFilter?[row].roomCode ?? ""
            return roomDataFilter?[row].roomCode ?? ""
            
        }
        else{
            return "vishnu"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if txtTag == 1{
            locIndex = row
            locationTxt.text = rowsLoc?[row].locationName ?? ""
        }else if txtTag == 7 {
            selectedIndex = row
            roomTypeTxt.text = rowsRoom?[row].typeName ?? ""
        //    disableArrangment()
        }else if txtTag == 8 {
            selectedIndex = row
            arrangmentTct.text = arrangModel?[row].pattern_x002f_Design ?? ""
          
        }
        else if txtTag == 9 {
            selectedIndex = row
            roomCodeTxt.text = roomDataFilter?[row].roomCode ?? ""
        }
        else{
//            selectedIndex = row
//            roomTypeTxt.text = "\(rowsData?[row].capacity ?? 0)"
        }
      
    }
    func disableArrangment()  {
        if rowsRoom?[selectedIndex].id == 1 {
            arrangmentTct.isEnabled = false
            arrangmentTct.text = ""
            self.delegate?.selectedTxtField(txtField: arrangmentTct)
            
        }else{
            arrangmentTct.isEnabled = true

        }
   
    }

}
extension RoomBTVC : RoomBookingVCDelegate{
    func selectIndex() {
        
    }
}

extension Calendar {
   private func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day! + 1 // <1>
    }
}
