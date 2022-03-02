//
//  VisitorListVC.swift
//  Staqo
//
//  Created by SHAILY on 15/03/21.
//

import UIKit

class VisitorListVC:  BaseVC,UITextFieldDelegate {
    
    var header:HeaderView!
    @IBOutlet weak var herderView: HeaderView!
    @IBOutlet weak var hideBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    var toolbar = UIToolbar()
    private let kVisiterListTVC = "VisiterListTVC"
    var viewModal: VisiterListViewModal!
    var viewModalEmp: EmpViewModal!
    var filteredData:[Value]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:70))
        header.delegate = self
        herderView.addSubview(header)
        
        viewModalEmp = EmpViewModal(dataSource: EmpDataSource())
        viewModalEmp._delegate = self
        viewModalEmp.bootstrap()
        viewModal = VisiterListViewModal(dataSource: VisitorListDataSource())
        viewModal.delegate = self
        getImage()
        hideBtn.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        searchBar.resignFirstResponder()
        searchBar.delegate = self
    
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        searchBar.inputAccessoryView = toolbar
        

        tblView.register(UINib(nibName: kVisiterListTVC, bundle: nil), forCellReuseIdentifier: kVisiterListTVC)
        // Do any additional setup after loading the view.
        
        
        
    }

    @objc func doneClicked(){
        view.endEditing(true)
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
   
    @IBAction func hidekeyboard(_ sender: Any) {
        
        searchBar.text = nil
        hideBtn.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        searchBar.resignFirstResponder()
        filteredData = viewModal.valueData
        tblView.reloadData()

    }
    
}
extension VisitorListVC:UISearchBarDelegate{
   
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
       

        if searchText.isEmpty == false {
            

            filteredData = viewModal.valueData?.filter {
                return ($0.fields?.name?.localizedCaseInsensitiveContains(searchText) ?? false || $0.fields?.mobileno1?.contains(searchText) ?? false)
            }


        }else{
            filteredData = viewModal.valueData
        }
        
        tblView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tblView.resignFirstResponder()
        hideBtn.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

extension VisitorListVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kVisiterListTVC, for: indexPath) as! VisiterListTVC
        cell.dataBind(data: filteredData?[indexPath.row].fields)
        //cell.dataBind(data: baseModel?.freeRoomModel?[indexPath.row])
        cell.callBtn.tag = indexPath.row
        cell.callBtn.addTarget(self, action: #selector(self.callBtnTap(_:)), for: .touchUpInside);
        cell.emailBtn.tag = indexPath.row
        cell.emailBtn.addTarget(self, action: #selector(self.emailBtnTap(_:)), for: .touchUpInside);
        return cell
    }
    
 
   

    //Code Cell Selected
    
    @objc func callBtnTap(_ sender : UIButton){
        
        if viewModal.valueData?[sender.tag].fields?.mobileno1 != nil{
                    guard let number = URL(string: "tel://" + (viewModal.valueData?[sender.tag].fields?.mobileno1)! ) else { return }
                    //guard let number = URL(string: "tel://" + viewModelUser.arrVisiterList[sender.tag].mobileno1) else { return }
                    UIApplication.shared.open(number)
        }else{
            showErrorMessage(title: "Alert", message: "Mobile no. is blank.") { (action) in
               
            }
        }
//        guard let number = URL(string: "tel://" + (viewModal.valueData?[sender.tag].fields?.mobileno2)! ) else { return }
//        //guard let number = URL(string: "tel://" + viewModelUser.arrVisiterList[sender.tag].mobileno1) else { return }
//        UIApplication.shared.open(number)
    }
    
    @objc func emailBtnTap(_ sender : UIButton){
        
        if viewModal.valueData?[sender.tag].fields?.emailid != nil{
            guard let number = URL(string: "mailto:" + (viewModal.valueData?[sender.tag].fields?.emailid)! ) else { return }
                UIApplication.shared.open(number)
        }else{
            showErrorMessage(title: "Alert", message: "Email ID is blank.") { (action) in
               
            }
        }
       
       
        
    }
    
    
    
    
}



extension VisitorListVC: ViewModelDelegate{
    func willLoadData() {
        startLoader()

    }
    
    func didLoadData() {
        
        stopLoader()
        filteredData = viewModal.valueData 
        self.tblView.reloadData()
    }
    
    func didFail(error: CustomError) {
        
        showErrorMessage(title: "Error", error: error) { (action) in
            if error.localizedDescription.contains("401 Unauthorized") {
                print("401")
                self.showMessage(title: "", message: CustomError.Logout.localizedDescription, btnConfirmTitle:"YES", btnCancelTitle: "NO") { (isYes, action) in
                    if isYes {
                        let vc = Constant.getViewController(storyboard: Constant.kMainStoryboard, identifier: Constant.kLoginVC, type: LoginVC.self)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
           
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


