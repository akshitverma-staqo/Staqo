//
//  NotificationTableViewCell.swift
//  DemoApp
//
//  Created by ERP on 24/01/21.
//  Copyright © 2021 ERP. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var readUnreadImg: UIImageView!
    @IBOutlet weak var sadowView: UIView!
    @IBOutlet weak var notificationImageBackView: UIView!
    @IBOutlet weak var NotificationTime: UILabel!
    @IBOutlet weak var notificationSubtitle: UILabel!
    @IBOutlet weak var notificationTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        notificationImageBackView.layer.cornerRadius = 6
        notificationImageBackView.clipsToBounds = true
        sadowView.dropShadow()
        innerView.layer.cornerRadius = 10
        innerView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func dataBind(data:[Value]? , index:IndexPath){
        notificationTitle.text = data?[index.row].fields?.title ?? ""
        notificationSubtitle.text =  data?[index.row].fields?.Description ?? ""
        NotificationTime.text =  Constant.formatModifiedDate(strDate: data?[index.row].fields?.created ?? "")
        readUnreadImg.isHidden = data?[index.row].fields?.isRead ?? false
        
    }
    
    
}
