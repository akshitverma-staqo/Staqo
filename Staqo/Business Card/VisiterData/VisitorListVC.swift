//
//  VisitorListVC.swift
//  Staqo
//
//  Created by SHAILY on 15/03/21.
//

import UIKit

class VisitorListVC:  BaseVC {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    var viewModal: VisiterListViewModal!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModal = VisiterListViewModal(dataSource: VisitorListDataSource())
        viewModal.delegate = self
        viewModal.bootstrap()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension VisitorListVC: ViewModelDelegate{
    func willLoadData() {
        startLoader()

    }
    
    func didLoadData() {
        
        stopLoader()
        
        
        
    }
    
    func didFail(error: CustomError) {
        showErrorMessage(title: "Error", error: error) { (action) in
            
        }
        stopLoader()
    }
    
    
}
