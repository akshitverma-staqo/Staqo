//
//  ViewHelpTVC.swift
//  Staqo
//
//  Created by SHAILY on 01/04/21.
//

import UIKit

class ViewLogTicketTVC: UITableViewCell {

    @IBOutlet weak var closeDateTimeLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var subjectlbl: UILabel!
    @IBOutlet weak var ticketLbl: UILabel!
    var requestData:[Requests]?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - DataBind

    func dataBind(data:Requests?) {
  
        ticketLbl.text = data?.requestid ?? ""
        subjectlbl.text = data?.subject ?? ""
        dateTimeLbl.text = data?.created_time ?? ""
        statusLbl.text = data?.status ?? ""
        closeDateTimeLbl.text = data?.due_by_time ?? ""

        
    }
    
}
