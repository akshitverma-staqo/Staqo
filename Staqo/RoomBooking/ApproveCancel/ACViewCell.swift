//
//  ACViewCell.swift
//  Staqo
//
//  Created by SHAILY on 04/04/21.
//

import UIKit


protocol ACViewCellDelegate:class {
    
    func approveCancel(bookingId:Int,roomStatus:String, approvedBy:String, userType:String,cancelBy: String, cancelRemark: String,isCancel:String)
}
class ACViewCell: UITableViewCell {

    @IBOutlet weak var btnCancel1: UIButton!
    @IBOutlet weak var cancelClick: UIButton!
    @IBOutlet weak var approveClick: UIButton!
    @IBOutlet weak var roomCapacity: UILabel!
    @IBOutlet weak var roomCodeLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var purposeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    var delegate: ACViewCellDelegate?
    var cancelData : [BRVModel]?
    var indexpath : IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if UserDefaults.standard.getWebStatus() == "A" {
            print("Admin")
            

        }else{
            print("User")
            approveClick.isHidden = true

        }
        // Configure the view for the selected state
    }
    
    func dataBind(data:[BRVModel]? , index:IndexPath){
        cancelData = data
        self.indexpath = index
        roomCapacity.text = "\(data?[index.row].attendents ?? 0)"
        roomCodeLbl.text =  data?[index.row].roomCode ?? ""
        dateTimeLbl.text =  data?[index.row].fromDateTime ?? ""
        purposeLbl.text = data?[index.row].purpose ?? ""
        nameLbl.text = data?[index.row].bookedBy ?? ""
        
    }
    

    @IBAction func btnCancelTap(_ sender: UIButton) {
        
        if UserDefaults.standard.getWebStatus() == "A" {
            print("Admin")
            
            delegate?.approveCancel(bookingId: cancelData?[indexpath.row].bookingId ?? 0 , roomStatus: "C", approvedBy: "", userType: "A", cancelBy: UserDefaults.standard.getProfile()?.email ?? "", cancelRemark:"Cancel by Admin", isCancel: "Cancel")
            
        }else{
            print("User")
            
            delegate?.approveCancel(bookingId: cancelData?[indexpath.row].bookingId ?? 0 , roomStatus: "C", approvedBy: "", userType: "U", cancelBy: UserDefaults.standard.getProfile()?.email ?? "", cancelRemark:"Cancel by User", isCancel: "Cancel")
            
        }
    }
   
   
    @IBAction func btnApproveTap(_ sender: UIButton) {
        if UserDefaults.standard.getWebStatus() == "A" {
            print("Admin")
            delegate?.approveCancel(bookingId: cancelData?[indexpath.row].bookingId ?? 0 , roomStatus: "A", approvedBy: UserDefaults.standard.getProfile()?.email ?? "", userType: "A", cancelBy: "", cancelRemark:"", isCancel:"Approve")
            
        }else{
            print("User")
            
        }
        
    }
    
}
