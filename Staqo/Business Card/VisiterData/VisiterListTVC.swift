//
//  UserCell.swift
//  MVVM+Json
//
//  Created by Yogesh Patel on 4/8/20.
//  Copyright © 2020 Yogesh Patel. All rights reserved.
//

import UIKit

class VisiterListTVC: UITableViewCell {

    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var compNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var jobTitlLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var visiterCardImg: UIImageView!
    
    var modelUser: VisiterListModel?{
        
        didSet{
            userConfiguration()
           
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    @IBAction func callBtnTap(_ sender: Any) {
        
    }
    
    @IBAction func emailBtnTap(_ sender: Any) {
        
        print("Hello this is email")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    func userConfiguration(){
        mobileLbl.text = modelUser?.mobileno1
       // compNameLbl.text = modelUser?.companyname
        //websiteLbl.text = modelUser?.websitename
        //jobTitlLbl.text = modelUser?.jobtitle
        addressLbl.text = modelUser?.addressline1
        nameLbl.text = modelUser?.name
        emailLbl.text = modelUser?.emailid
         
       
     
      
        
       
    }
    
  
}
