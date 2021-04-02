//
//  BooKRoomVC.swift
//  Staqo
//
//  Created by SHAILY on 02/04/21.
//

import UIKit

class BooKRoomVC: BaseVC, UITableViewDelegate {
    var viewModel:BookRoomViewModel!
    var header:HeaderView!
    @IBOutlet weak var roomSegment: UISegmentedControl!
    @IBOutlet weak var herderView: HeaderView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:80))
        header.delegate = self
        herderView.addSubview(header)

        viewModel = BookRoomViewModel(dataSource: BookRoomDataSource())
        viewModel.delegate = self
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "BookRoomTVC", bundle: nil), forCellReuseIdentifier: "BookRoomTVC")
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
        case 1:
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
        stopLoader()
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
        return 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookRoomTVC", for: indexPath) as! BookRoomTVC
       
      
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
