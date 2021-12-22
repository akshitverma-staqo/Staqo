//
//  LogTicketVC.swift
//  Staqo
//
//  Created by SHAILY on 01/04/21.
//

import UIKit

class LogTicketVC: BaseVC, UITableViewDelegate {
    var header:HeaderView!
    @IBOutlet weak var herderView: HeaderView!
    private let kLogTicketTVC = "LogTicketTVC"

    var viewModel:LogTicketViewModel!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:70))
        header.delegate = self
        herderView.addSubview(header)
        // Do any additional setup after loading the view.
        viewModel = LogTicketViewModel(dataSource: LogTicketDataSource())
        viewModel.delegate = self
        viewModel._delegate = self

        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: kLogTicketTVC, bundle: nil), forCellReuseIdentifier: kLogTicketTVC)
        self.navigationController?.isNavigationBarHidden = true
        
        getImage()
        viewModel.bootstrap()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LogTicketVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLogTicketTVC, for: indexPath) as! LogTicketTVC
        cell.delegate = self
        cell.dataBind(data: viewModel.rows, index: indexPath, vc: self)
        cell.dataBind1(dataSubCat: viewModel.rowsSubCat, index: indexPath)
        cell.dataBind2(dataprject: viewModel.prjectrows, index: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
    
}

extension LogTicketVC :TSModelDelegate{
    func didStopLoader() {
        stopLoader()
        tableView.reloadData()

        
    }
    func ticketUploadStatus() {
        stopLoader()
        showErrorMessage(title: "", message: "Successfully Submited") { (action) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
  
  
}

extension LogTicketVC : ViewModelDelegate{
    func willLoadData() {
        startLoader()
        
       
    }
    
    func didLoadData() {
        stopLoader()
        if viewModel.rows?.count == 0{
            showErrorMessage(title: "", message: "Something went wrong. Please try again.") { (action) in
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            tableView.reloadData()
        }
       
        
        
        
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
extension LogTicketVC: HeaderViewDelegate{
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


extension LogTicketVC : LogTicketTCVDelegate{
    func loaderrun() {
        startLoader()
    }
    
    func loaderstop() {
        stopLoader()
    }
    
  
    
 
    func uploadImage(file: String, ID: String, fileName:String) {
        viewModel.file = file
        viewModel.fileName = fileName
        
    }
   
    func submitRequest(desc: String, subj: String, catID: String, prioName: String, subID: String, email_ID:String, projName:String) {
//        guard  let value = Helper.createTicket(desc: desc, subj: subj, catID: catID, prioName: prioName, subID: subID, email_ID: email_ID, projName: projName) else {
//                return
//            }
//            do {
//            let data = try JSONEncoder().encode(value)
//                let str = String(data: data, encoding:.utf8)
//                print(str)
                
                viewModel.submitTicketData(desc: desc, subj: subj, catID: catID, prioName: prioName, subID: subID, email_ID: email_ID, projName: projName)
//            }catch{
//
//            }
        
    }
    func getSubCat(ID: String) {
        viewModel.getSubCatType(ID: ID)
    }
    
    func showMsgValidation(msg: String) {
        showErrorMessage(title: "Error...", message: msg) { (action) in
            
        }
    }

}


