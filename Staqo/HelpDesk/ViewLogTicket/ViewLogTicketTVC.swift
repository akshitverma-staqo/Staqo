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
  
        ticketLbl.text = data?.id ?? ""
        subjectlbl.text = data?.subject ?? ""
        dateTimeLbl.text = data?.created_time?.display_value ?? ""
        statusLbl.text = data?.status?.name ?? ""
        closeDateTimeLbl.text = data?.created_time?.display_value ?? ""

    }
    
}
