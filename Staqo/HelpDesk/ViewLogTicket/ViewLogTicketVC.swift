//
//  ViewLogTicketVC.swift
//  Staqo
//
//  Created by SHAILY on 01/04/21.
//

import UIKit

class ViewLogTicketVC: BaseVC ,UITableViewDelegate{
    var viewModel:LogTicketViewModel!
    @IBOutlet weak var herderView: HeaderView!

    var header:HeaderView!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:100))
        header.delegate = self
       
        herderView.addSubview(header)
        // Do any additional setup after loading the view.
        viewModel = LogTicketViewModel(dataSource: LogTicketDataSource())
        viewModel.delegate = self

        tableView.register(UINib(nibName: "ViewLogTicketTVC", bundle: nil), forCellReuseIdentifier: "ViewLogTicketTVC")
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
extension ViewLogTicketVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewLogTicketTVC", for: indexPath) as! ViewLogTicketTVC
       
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Constant.getViewController(storyboard: Constant.kHelpDesk, identifier: Constant.kTicketStatusVC, type: TicketStatusVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
extension ViewLogTicketVC : ViewModelDelegate{
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
extension ViewLogTicketVC: HeaderViewDelegate{
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
