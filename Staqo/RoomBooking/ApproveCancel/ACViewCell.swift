//
//  ACViewCell.swift
//  Staqo
//
//  Created by SHAILY on 04/04/21.
//

import UIKit

class ACViewCell: UITableViewCell {

    @IBOutlet weak var cancelClick: UIButton!
    @IBOutlet weak var approveClick: UIButton!
    @IBOutlet weak var roomCapacity: UILabel!
    @IBOutlet weak var roomCodeLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var purposeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if UserDefaults.standard.getWebStatus() == "Admin" {
            print("Admin")
            
            
        }else{
            
            print("User")
            
            approveClick.isHidden = true
            
            
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dataBind(data:[BRVModel]? , index:IndexPath){
        roomCapacity.text = "\(data?[index.row].attendents ?? 0)"
        roomCodeLbl.text =  data?[index.row].roomCode ?? ""
        dateTimeLbl.text =  data?[index.row].fromDateTime ?? ""
        purposeLbl.text = data?[index.row].purpose ?? ""
        nameLbl.text = data?[index.row].bookedBy ?? ""
    }
    
    
    
    @IBAction func btnCancelTap(_ sender: Any) {
        if UserDefaults.standard.getWebStatus() == "Admin" {
            print("Admin")
        }else{
            print("User")
        }
    }

    @IBAction func btnApproveTap(_ sender: Any) {
        if UserDefaults.standard.getWebStatus() == "Admin" {
            print("Admin")
        }else{
            print("User")
        }
        
    }
    
}
