//
//  HomeMenuCollectionViewCell.swift
//  Staqo
//
//  Created by SHAILY on 22/03/21.
//

import UIKit

class HomeMenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func dataBind (index:IndexPath ,data:[MenuModel]?) {
        imgView1.image = UIImage(named: "\(data?[index.row].seqid ?? 0)")
        lbl1.text = data?[index.row].menuname ?? ""
        if data?[index.row].isSelected ?? false {
            imgView2.image = UIImage(named: "blob1")
        }else{
            imgView2.image = UIImage(named: "blob2")
            
        }
    }

}
