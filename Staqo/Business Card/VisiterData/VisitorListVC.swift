//
//  VisitorListVC.swift
//  Staqo
//
//  Created by SHAILY on 15/03/21.
//

import UIKit

class VisitorListVC:  BaseVC {
    
    var header:HeaderView!
    @IBOutlet weak var herderView: HeaderView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    private let kVisiterListTVC = "VisiterListTVC"
    var viewModal: VisiterListViewModal!
    var viewModalEmp: EmpViewModal!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:80))
        header.delegate = self
        herderView.addSubview(header)
        
        viewModalEmp = EmpViewModal(dataSource: EmpDataSource())
        viewModalEmp._delegate = self
        viewModalEmp.bootstrap()
        viewModal = VisiterListViewModal(dataSource: VisitorListDataSource())
        viewModal.delegate = self
      
        tblView.register(UINib(nibName: kVisiterListTVC, bundle: nil), forCellReuseIdentifier: kVisiterListTVC)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        self.navigationController?.isNavigationBarHidden = true
    }
   

}

extension VisitorListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.valueData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kVisiterListTVC, for: indexPath) as! VisiterListTVC
        cell.dataBind(data: viewModal.valueData?[indexPath.row].fields)
        //cell.dataBind(data: baseModel?.freeRoomModel?[indexPath.row])
        cell.callBtn.tag = indexPath.row
        cell.callBtn.addTarget(self, action: #selector(self.callBtnTap(_:)), for: .touchUpInside);
        cell.emailBtn.tag = indexPath.row
        cell.emailBtn.addTarget(self, action: #selector(self.emailBtnTap(_:)), for: .touchUpInside);
        return cell
    }
    
    //Code Cell Selected
    
    @objc func callBtnTap(_ sender : UIButton){
        
        guard let number = URL(string: "tel://" + (viewModal.valueData?[sender.tag].fields?.mobileno2)! ) else { return }
        //guard let number = URL(string: "tel://" + viewModelUser.arrVisiterList[sender.tag].mobileno1) else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func emailBtnTap(_ sender : UIButton){
        guard let number = URL(string: "mailto:" + (viewModal.valueData?[sender.tag].fields?.emailid)! ) else { return }
        UIApplication.shared.open(number)
    }
    
    
    
    
}



extension VisitorListVC: ViewModelDelegate{
    func willLoadData() {
        startLoader()

    }
    
    func didLoadData() {
        
        stopLoader()
        self.tblView.reloadData()
    }
    
    func didFail(error: CustomError) {
        showErrorMessage(title: "Error", error: error) { (action) in
            
        }
        stopLoader()
    }
    
    
}

extension VisitorListVC : EmpViewModalDelegate {
    func getEmpID(ID: String) {
        stopLoader()
        self.viewModal.getVisitorList(ID: ID)
    }
}
extension VisitorListVC: HeaderViewDelegate{
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
