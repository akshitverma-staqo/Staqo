//
//  ApproveCancelVC.swift
//  Staqo
//
//  Created by SHAILY on 04/04/21.
//

import UIKit

class ApproveCancelVC: BaseVC, UITableViewDelegate {
    var viewModel:ACViewModel!
    private let kACViewCell = "ACViewCell"
    var header:HeaderView!
    @IBOutlet weak var herderView: HeaderView!

    @IBOutlet weak var roomSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:80))
        header.delegate = self
        herderView.addSubview(header)
        
        viewModel = ACViewModel(dataSource: ACDataSource())
        viewModel.delegate = self
        
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
            print("Free Room")
            tableView.reloadData()
        case 1:
            tableView.reloadData()
            print("Booked Room")
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

extension ApproveCancelVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows?.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kACViewCell, for: indexPath) as! ACViewCell
        
        cell.dataBind(data: viewModel.rows, index: indexPath)
        

      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
    
}
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
