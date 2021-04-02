//
//  RoomBookingVC.swift
//  Staqo
//
//  Created by SHAILY on 24/03/21.
//

import UIKit

class RoomBookingVC: BaseVC, UITableViewDelegate {
    var viewModel:RoomBookingViewModel!
    var header:HeaderView!
    
    
    
    
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var herderView: HeaderView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet var viewPicker: UIView!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:80))
        header.delegate = self
        herderView.addSubview(header)

        viewModel = RoomBookingViewModel(dataSource: RoomDataSource())
        viewModel.delegate = self
        // Do any additional setup after loading the view.
        self.tblView.delegate = self
        self.tblView.dataSource = self
        tblView.register(UINib(nibName: "RoomBTVC", bundle: nil), forCellReuseIdentifier: "RoomBTVC")
        viewModel.bootstrap()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        self.navigationController?.isNavigationBarHidden = true
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
extension RoomBookingVC : ViewModelDelegate{
    func willLoadData() {
        startLoader()
        
       
    }
    
    func didLoadData() {
        stopLoader()
        tblView.reloadData()
        
        
        
    }
    
    func didFail(error: CustomError) {
        showErrorMessage(title: "Error", error: error) { (action) in
            
        }
        stopLoader()
    }
    
    
}

extension RoomBookingVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomBTVC", for: indexPath) as! RoomBTVC
        cell.dataBind(data: viewModel.rows, roomData: viewModel.rowsRoom, locData: viewModel.rowsLocation, arrangData:viewModel.arrangModel, picker: picker, viewDataPicker:viewPicker)
      
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
    
}
extension RoomBookingVC : RoomBTVCDelegate{
    func selectedTxtField(txtField: UITextField) {
        if txtField.tag == 3 {
            datePicker.isHidden = false
            datePicker.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
            datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
            datePicker.maximumDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())

            txtField.inputView = datePicker
            
        }else if txtField.tag == 4 {
            datePicker.isHidden = false
            datePicker.datePickerMode = .time
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let min = dateFormatter.date(from: "9:00")
            let max = dateFormatter.date(from: "18:00")
            datePicker.minimumDate = min
            datePicker.maximumDate = max
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
            txtField.inputView = datePicker
        }else if  txtField.tag == 5 {
            datePicker.isHidden = false
            datePicker.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
            datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
            datePicker.maximumDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())

            txtField.inputView = datePicker
        }else if txtField.tag == 6 {
            datePicker.isHidden = false
            datePicker.datePickerMode = .time
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let min = dateFormatter.date(from: "9:00")
            let max = dateFormatter.date(from: "18:00")
            datePicker.minimumDate = min
            datePicker.maximumDate = max
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
            txtField.inputView = datePicker
        }else{
            datePicker.isHidden = true
        txtField.inputView = viewPicker
        picker.reloadAllComponents()
        }
    }
    
    
}

extension RoomBookingVC: HeaderViewDelegate{
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
