//
//  HelpTVC.swift
//  Staqo
//
//  Created by SHAILY on 01/04/21.
//

import UIKit

class LogTicketTVC: UITableViewCell {

    @IBOutlet weak var priorityTxt: UITextField!
    @IBOutlet weak var companyTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var subCatTxt: UITextField!
    @IBOutlet weak var categoryTxt: UITextField!
    @IBOutlet weak var subjectTxt: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func btnSubmitTap(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
