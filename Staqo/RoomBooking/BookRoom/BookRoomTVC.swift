//
//  BookRoomTVC.swift
//  Staqo
//
//  Created by SHAILY on 02/04/21.
//

import UIKit
protocol BookRoomTVCDelegate:class {
    func bookRoomData(index:Int)
    func photoView(index:Int)

}

class BookRoomTVC: UITableViewCell {

    
    @IBOutlet weak var bookRoomClick: UIButton!
    @IBOutlet weak var roomFeatureLbl: UILabel!
    @IBOutlet weak var roomTypeLbl: UILabel!
    @IBOutlet weak var roomCodeLbl: UILabel!
    @IBOutlet weak var capacityLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    var delegate:BookRoomTVCDelegate?
    @IBOutlet weak var btnPhoto: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btnPhotoView(_ sender: UIButton) {
        delegate?.photoView(index: sender.tag)
    }

    @IBAction func btBookRoomTap(_ sender: UIButton) {
        delegate?.bookRoomData(index: sender.tag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dataBind(data:FreeRoomModel?) {
        roomCodeLbl.text = ": " + (data?.roomCode ?? "")
        roomTypeLbl.text = ": " + (data?.roomtype ?? "")
        capacityLbl.text = ": " + "\(data?.capacity ?? 0)"
        roomFeatureLbl.text = ": " + (data?.roomfeatures ?? "")
        dateLbl.text = ": " + (data?.fdate ?? "")
        dayLbl.text = ": " + (data?.rday ?? "")
        timeLbl.text = ": " + (data?.ftime ?? "")
        bookRoomClick.isHidden = false
        btnPhoto.isHidden = false
    }
    func dataBind1(data:BookedRoomModel?) {
        roomCodeLbl.text = ": " + (data?.roomCode ?? "")
        roomTypeLbl.text = ": " + (data?.roomType ?? "")
        capacityLbl.text = ": " + "\(data?.attendents ?? 0)"
        roomFeatureLbl.text = ": " + (data?.roomfeatures ?? "")
        dateLbl.text = ": " + Constant.formatModifiedDate(strDate:  data?.fromDate ?? "") + " to " + Constant.formatModifiedDate(strDate:  data?.toDate ?? "")
        dayLbl.text = ": " + (data?.rday ?? "")
        timeLbl.text = ": " + Constant.formatModifiedTime(strDate:  data?.fromTime ?? "") + " to " + Constant.formatModifiedTime(strDate:  data?.toTime ?? "")
        bookRoomClick.isHidden = true
        btnPhoto.isHidden = true

    }
    
}
