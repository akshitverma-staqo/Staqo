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
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:80))
        header.delegate = self
       
        herderView.addSubview(header)
        // Do any additional setup after loading the view.
        viewModel = LogTicketViewModel(dataSource: LogTicketDataSource())
        viewModel.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: kLogTicketTVC, bundle: nil), forCellReuseIdentifier: kLogTicketTVC)
        self.navigationController?.isNavigationBarHidden = true

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

extension LogTicketVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLogTicketTVC, for: indexPath) as! LogTicketTVC
        cell.delegate = self
        cell.dataBind(data: viewModel.rows, index: indexPath, vc: self)
        cell.dataBind1(dataSubCat: viewModel.rowsSubCat, index: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
    
}

extension LogTicketVC : ViewModelDelegate{
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
    func uploadImage(file: Data, ID: String) {
        viewModel.ticketImageUpload(file: file, ID: ID)
    }
    
    func submitRequest(desc: String, subj: String, catID: String, prioName: String, subID: String) {
        guard  let value = Helper.createTicket(desc: desc, subj: subj, catID: catID, prioName: prioName, subID: subID) else {
                return
            }
            do {
            let data = try JSONEncoder().encode(value)
                let str = String(data: data, encoding:.utf8)
                print(str)
                viewModel.submitTicketData(value: str!)
            }catch{
                
            }
        
    }
    func getSubCat(ID: String) {
        viewModel.getSubCatType(ID: ID)
    }
    
    func showMsgValidation(msg: String) {
        showErrorMessage(title: "Error...", message: msg) { (action) in
            
        }
    }

}
