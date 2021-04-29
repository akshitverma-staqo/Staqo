//
//  BooKRoomVC.swift
//  Staqo
//
//  Created by SHAILY on 02/04/21.
//

import UIKit

class BooKRoomVC: BaseVC, UITableViewDelegate {
    var viewModel:BookRoomViewModel!
    var roomViewModel:RoomBookingViewModel!
    var header:HeaderView!
    private let kBookRoomTVC = "BookRoomTVC"
    @IBOutlet weak var roomSegment: UISegmentedControl!
    @IBOutlet weak var herderView: HeaderView!
    @IBOutlet weak var tableView: UITableView!
    var baseModel:BaseModel?
    var searchValue:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:70))
        header.delegate = self
        herderView.addSubview(header)

        viewModel = BookRoomViewModel(dataSource: BookRoomDataSource())
        viewModel.delegate = self
        
        roomViewModel = RoomBookingViewModel(dataSource: RoomDataSource())
        roomViewModel._delegate = self
        getImage()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: kBookRoomTVC, bundle: nil), forCellReuseIdentifier: kBookRoomTVC)
        self.checkedData(index:  roomSegment.selectedSegmentIndex)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        header.btnNotiyCount.setTitle("\(UserDefaults.standard.getNotifyCount() )", for: .normal)

        self.navigationController?.isNavigationBarHidden = true
    }
    func checkedData(index:Int){
        if index == 0 {
            if baseModel?.freeRoomModel == [] ||  baseModel?.freeRoomModel == nil {
                showErrorMessage(title: "Alert", message: "Free Room Not Available.") { (action) in
                
                }
        }
     
        }else if index == 1 {
            if  baseModel?.bookedRoomModel == [] ||  baseModel?.bookedRoomModel == nil {
                 showErrorMessage(title: "Alert", message: "Booked Room Not Available.") { (action) in
                 
                 }
             }
        }
    }
    
   
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch roomSegment.selectedSegmentIndex {
        case 0:
            print("Free Room")
            self.checkedData(index:  roomSegment.selectedSegmentIndex)
            tableView.reloadData()
        case 1:
            self.checkedData(index:roomSegment.selectedSegmentIndex)
            tableView.reloadData()
            print("Booked Room")
        default:
            break;
        }
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
extension BooKRoomVC : ViewModelDelegate{
    func willLoadData() {
        startLoader()
        
       
    }
    
    func didLoadData() {
       // stopLoader()
        showErrorMessage(title: "", message: "Room Booked Successfully.") { (action) in
            self.roomViewModel.searchRoomData(value: self.searchValue)

        }
        tableView.reloadData()
        
    }
    
    func didFail(error: CustomError) {
        showErrorMessage(title: "Error", error: error) { (action) in
            
        }
        stopLoader()
    }
    
    
}

extension BooKRoomVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if roomSegment.selectedSegmentIndex == 0 {
            
            return baseModel?.freeRoomModel?.count ?? 0
        }else{
            return baseModel?.bookedRoomModel?.count ?? 0
        }
        
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kBookRoomTVC, for: indexPath) as! BookRoomTVC
        if roomSegment.selectedSegmentIndex == 0 {
                cell.dataBind(data: baseModel?.freeRoomModel?[indexPath.row])
                cell.bookRoomClick.tag = indexPath.row
            cell.btnPhoto.tag = indexPath.row
            
            }else{
            cell.dataBind1(data:  baseModel?.bookedRoomModel?[indexPath.row])
                        cell.bookRoomClick.tag = indexPath.row
        }
        cell.delegate = self
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
    
}
extension BooKRoomVC: HeaderViewDelegate{
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
extension BooKRoomVC : BookRoomTVCDelegate{
    func photoView(index: Int) {
        let vc = Constant.getViewController(storyboard: Constant.kRoomStroyboard, identifier: Constant.kRoomPhotoVC, type: RoomPhotoVC.self)
      vc.urlString =  baseModel?.freeRoomModel?[index].webUrl ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func bookRoomData(index: Int) {
        let free = baseModel?.freeRoomModel?[index]
        let selectedOption = baseModel?.selectedRoomOptionModel
        showMessage(title: "", message: "Do you want to book Room?", btnConfirmTitle: "Yes", btnCancelTitle:"No") { (isYes, action) in
            if isYes{
                self.viewModel.roomBookService(roomId: Int(free?.id ?? 0), attendents: Int(free?.capacity ?? 0), fromDateTime: selectedOption?.fromDateTime ?? "", toDateTime: selectedOption?.toDateTime  ?? "", roomStatus: selectedOption?.roomStatus  ?? "", purpose: selectedOption?.remarks  ?? "", visitorType: selectedOption?.visitorType  ?? "", roomType: selectedOption?.roomType ?? "", arrangementType: selectedOption?.arrangementType ?? "", notificationId: "\(free?.id ?? 0)", roomCode: free?.roomCode ?? "", recurringDay: selectedOption?.recurringDay ?? "", bookedBy: selectedOption?.bookedBy ?? "", roomfeatures: free?.roomfeatures ?? "", roomtypeid: free?.roomtypeid ?? "")
            }
        }
      
    }
}
extension BooKRoomVC:RoomBookingViewModelDelegate{
    func updatedResult(data: BaseModel?) {
        stopLoader()
        baseModel = data
        tableView.reloadData()
    }
}
