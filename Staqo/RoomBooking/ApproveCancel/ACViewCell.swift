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

    @IBOutlet weak var roomTypeLbl: UILabel!
    @IBOutlet weak var visitorsTypeLbl: UILabel!
    @IBOutlet weak var btnCancel1: UIButton!
    @IBOutlet weak var cancelClick: UIButton!
    @IBOutlet weak var approveClick: UIButton!
    @IBOutlet weak var roomCapacity: UILabel!
    @IBOutlet weak var roomCodeLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
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
        if data?[index.row].visitorType ?? "" == "v" || data?[index.row].visitorType ?? "" == "V"{
            visitorsTypeLbl.text = "Visitors"
        }else if data?[index.row].visitorType ?? "" == "e" || data?[index.row].visitorType ?? "" == "E" {
            visitorsTypeLbl.text = "Employees"
        }else{
            visitorsTypeLbl.text = "VIP"
        }
        roomTypeLbl.text = data?[index.row].roomType ?? ""
        roomCodeLbl.text =  data?[index.row].roomCode ?? ""
        dateTimeLbl.text =  Constant.formatModifiedDate(strDate:  data?[index.row].fromDate ?? "") + " to " + Constant.formatModifiedDate(strDate:  data?[index.row].toDate ?? "")
        timeLbl.text = Constant.formatModifiedTime(strDate:  data?[index.row].fromTime ?? "") + " to " + Constant.formatModifiedTime(strDate:  data?[index.row].toTime ?? "")
        dayLbl.text = data?[index.row].rday ?? ""
        purposeLbl.text = data?[index.row].purpose ?? ""
        nameLbl.text = data?[index.row].bookedBy ?? ""
       // visitorsTypeLbl.text = data?[index.row].visitorType ?? ""
        
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
