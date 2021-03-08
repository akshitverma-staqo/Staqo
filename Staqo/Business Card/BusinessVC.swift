//
//  BusinessVC.swift
//  Staqo
//
//  Created by SHAILY on 06/03/21.
//

import UIKit
import VisionKit
import Vision

class BusinessVC: BaseVC {
    let ocr = CognitiveServices.sharedInstance.ocr
    
    @IBOutlet weak var searchBtnOutlet: UIButton!
    @IBOutlet weak var scanBtnOutlet: UIButton!
    @IBOutlet weak var businessBtnOutlet: UIButton!
    @IBOutlet weak var searchShadowView: UIView!
    @IBOutlet weak var scanShadowView: UIView!
    @IBOutlet weak var businessShadowView: UIView!
    
    var viewModal: BusinessViewModal!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        businessShadowView.dropShadow()
        scanShadowView.dropShadow()
        searchShadowView.dropShadow()
        businessBtnOutlet.layer.cornerRadius = 11
        searchBtnOutlet.layer.cornerRadius = 11
        scanBtnOutlet.layer.cornerRadius = 11
        businessBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        searchBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        scanBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension BusinessVC: ViewModelDelegate{
    func willLoadData() {
        startLoader()

    }
    
    func didLoadData() {
        
        stopLoader()
        
        
        
    }
    
    func didFail(error: CustomError) {
        showErrorMessage(title: "Error", error: error) { (action) in
            
        }
        stopLoader()
    }
    
    
}

