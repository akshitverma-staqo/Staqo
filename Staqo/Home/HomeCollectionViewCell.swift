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
    
    func dataBind(data:(imageArr:[String], curveArr:[String], TopLabArray:[String])? , index:IndexPath) {
        imgView1.image = UIImage(named: data?.imageArr[index.row] ?? "")
        imgView2.image = UIImage(named: data?.curveArr[index.row] ?? "")
        imgView3.image = UIImage(named: data?.TopLabArray[index.row] ?? "")
        lbl1.text = (data?.TopLabArray[index.row] ?? "")
         
    }

}
