//
//  HomeCollectionViewCell.swift
//  Staqo
//
//  Created by SHAILY on 18/02/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func dataBind(data:(imageArr:[String], curveArr:[String], TopLabArray:[String])) {
        imgView1.image = UIImage(named: data.imageArr["")
        
    }

}
