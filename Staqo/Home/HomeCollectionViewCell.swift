//
//  HomeCollectionViewCell.swift
//  Staqo
//
//  Created by SHAILY on 18/02/21.
//

import UIKit
import SDWebImage
class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func dataBind (index:IndexPath ,data:[MenuModel]?) {
        imgView1.image = UIImage(named: data?[index.row].title ?? "")
        lbl1.text = data?[index.row].menuname ?? ""
        if data?[index.row].isSelected ?? false {
            imgView2.image = UIImage(named: "blob1")
        }else{
            imgView2.image = UIImage(named: "blob2")
            
        }
    }
//    func databind1(data:[MenuModel]?, index:IndexPath){
//        self.lbl1.text = MenuModel?.
//    }
}
