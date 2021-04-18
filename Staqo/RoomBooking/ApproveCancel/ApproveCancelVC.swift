//
//  ApproveCancelVC.swift
//  Staqo
//
//  Created by SHAILY on 04/04/21.
//

import UIKit

class ApproveCancelVC: BaseVC {
    var viewModel:ACViewModel!
    private let kACViewCell = "ACViewCell"
    var header:HeaderView!
    @IBOutlet weak var herderView: HeaderView!
    var segmenStatus : String = ""
    @IBOutlet weak var roomSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:80))
        header.delegate = self
        herderView.addSubview(header)
        
        viewModel = ACViewModel(dataSource: ACDataSource())
        viewModel.delegate = self
        viewModel._delegate = self
        
        if UserDefaults.standard.getWebStatus() == "A" {
            print("Admin")
            roomSegment.setTitle("Approved", forSegmentAt: 0)
            roomSegment.setTitle("Unapproved", forSegmentAt: 1)
        }else{
            
            print("User")
            roomSegment.setTitle("Approved", forSegmentAt: 0)
            roomSegment.setTitle("Pending", forSegmentAt: 1)
        }
        
        
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: kACViewCell, bundle: nil), forCellReuseIdentifier: kACViewCell)
        viewModel.bootstrap()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch roomSegment.selectedSegmentIndex {
        case 0:
            print("Segment 0")
            tableView.reloadData()
           
            if viewModel?.rows?.count == 0 {
                    showErrorMessage(title: "Alert", message: "Data not Found.") { (action) in
                    }}
         
          
        case 1:
            tableView.reloadData()
            print("Segment 1")
            
            if  viewModel?.rows1?.count == 0 {
                       showErrorMessage(title: "Alert", message: "Data not Found.") { (action) in
                       
                       }  }
        default:
            break;
        }
    }

    

}
extension ApproveCancelVC : ViewModelDelegate{
    func willLoadData() {
        startLoader()
    }
    
    func didLoadData() {
        stopLoader()
        tableView.reloadData()
    }
    
    func didFail(error: CustomError) {
        showErrorMessage(title: "Error", error: error) { (action) in
            
        }
        stopLoader()
    }
    
    
}
extension ApproveCancelVC :ACViewModelDelegate{
    func getBookedData(status: String) {
        // stopLoader()
//        if status == "Cancel"{
//
//        }
        showErrorMessage(title: "", message: "Successfully \(status)") { (action) in
            self.viewModel.bootstrap()
            self.tableView.reloadData()
        }
    }
  
}
// MARK: - Tableview Delegate

extension ApproveCancelVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if roomSegment.selectedSegmentIndex == 0 {
            //A
           
            
            return viewModel.rows?.count ?? 0
        }else{
            return viewModel.rows1?.count ?? 0
        }
       
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kACViewCell, for: indexPath) as! ACViewCell
        
        cell.delegate = self
        
        
        
        if UserDefaults.standard.getWebStatus() == "A" {
            print("Admin")
            if roomSegment.selectedSegmentIndex == 0 {
                //A
                cell.dataBind(data: viewModel.rows, index: indexPath)
                cell.approveClick.isHidden = true
                cell.cancelClick.isHidden = true
                cell.btnCancel1.isHidden = false
            }else{
                //P
                cell.dataBind(data: viewModel.rows1, index: indexPath)
                cell.approveClick.isHidden = false
                cell.cancelClick.isHidden = false
                cell.btnCancel1.isHidden = true
            }        }else{
            
            print("User")
                if roomSegment.selectedSegmentIndex == 0 {
                    //A
                    cell.dataBind(data: viewModel.rows, index: indexPath)
                    cell.approveClick.isHidden = true
                    cell.cancelClick.isHidden = true
                    cell.btnCancel1.isHidden = false
                }else{
                    //P
                    cell.dataBind(data: viewModel.rows1, index: indexPath)
                    cell.approveClick.isHidden = true
                    cell.cancelClick.isHidden = true
                    cell.btnCancel1.isHidden = false
                }        }
        
        
        
        
        
        

        return cell
    }
   
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}

// MARK: - Header Delegate

extension ApproveCancelVC: HeaderViewDelegate{
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
extension ApproveCancelVC: ACViewCellDelegate{
    
    func approveCancel(bookingId: Int, roomStatus: String, approvedBy: String, userType: String, cancelBy: String, cancelRemark: String, isCancel: String)
    {
        showMessage(title: "", message: "Do you want to \(isCancel) this booking?", btnConfirmTitle: "Yes", btnCancelTitle:"No") { (isYes, action) in
            if isYes{
                self.viewModel.approveCancel(bookingId: bookingId, roomStatus: roomStatus, approvedBy: approvedBy, userType: userType, cancelBy: cancelBy, cancelRemark: cancelRemark, status: isCancel)
            }
        }
      
    }
    
    
  
}
