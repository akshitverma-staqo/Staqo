//
//  RoomBookingVC.swift
//  Staqo
//
//  Created by SHAILY on 24/03/21.
//

import UIKit
protocol RoomBookingVCDelegate:class {
    func selectIndex()
}
class RoomBookingVC: BaseVC, UITableViewDelegate {
    var viewModel:RoomBookingViewModel!
    var header:HeaderView!
    private let kRoomBTVC = "RoomBTVC"
    var delegate:RoomBookingVCDelegate?
    var searchValue:String = ""
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var herderView: HeaderView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet var viewPicker: UIView!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:70))
        header.delegate = self
        herderView.addSubview(header)

        viewModel = RoomBookingViewModel(dataSource: RoomDataSource())
        viewModel.delegate = self
        viewModel._delegate = self
        // Do any additional setup after loading the view.
        self.tblView.delegate = self
        self.tblView.dataSource = self
        tblView.register(UINib(nibName: kRoomBTVC, bundle: nil), forCellReuseIdentifier: kRoomBTVC)
        viewModel.bootstrap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        header.btnNotiyCount.setTitle("\(UserDefaults.standard.getNotifyCount() )", for: .normal)

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
    @objc func doneBtnClicked(){
       // delegate?.selectIndex()
    }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: kRoomBTVC, for: indexPath) as! RoomBTVC
        cell.dataBind(data: viewModel.rows, roomData: viewModel.rowsRoom, locData: viewModel.rowsLocation, arrangData:viewModel.arrangModel, picker: picker, viewDataPicker:viewPicker, delegateVC: delegate)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}
extension RoomBookingVC : RoomBTVCDelegate{
    func getArrangement(ID: String) {
        viewModel.getArrangmentType(ID: ID)
    }
    
    func getAllRooms(ID: String) {
        viewModel.getAllRoomData(ID: ID)
    }
    
    func showMsgValidation(msg: String) {
        showErrorMessage(title: "Error...", message: msg) { (action) in
            
        }
    }
    
    func selectedTxtField(txtField: UITextField) {
       
        txtField.inputView = viewPicker
        picker.reloadAllComponents()
     //   picker.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneBtnClicked))
        
    }
    func filledData(value: String) {
        searchValue = value
        viewModel.searchRoomData(value: value)
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
extension RoomBookingVC : RoomBookingViewModelDelegate{
    func updatedResult(data: BaseModel?) {
        stopLoader()
        let vc = Constant.getViewController(storyboard: Constant.kRoomStroyboard, identifier: Constant.kBooKRoomVC, type: BooKRoomVC.self)
        vc.searchValue = searchValue
        vc.baseModel = data
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
    
    
}
