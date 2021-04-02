//
//  BookRoomTVC.swift
//  Staqo
//
//  Created by SHAILY on 02/04/21.
//

import UIKit

class BookRoomTVC: UITableViewCell {

    
    @IBOutlet weak var roomFeatureLbl: UILabel!
    @IBOutlet weak var roomTypeLbl: UILabel!
    @IBOutlet weak var roomCodeLbl: UILabel!
    @IBOutlet weak var capacityLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btnPhotoView(_ sender: Any) {
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
