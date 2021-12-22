//
//  RoomPhotoVC.swift
//  Staqo
//
//  Created by SHAILY on 02/04/21.
//

import UIKit

class RoomPhotoVC: BaseVC
{
    var header:HeaderView!
    @IBOutlet weak var herderView: HeaderView!
    @IBOutlet weak var imageView: UIImageView!
    var viewModel:BookRoomViewModel!
    var urlString:String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:70))
        header.delegate = self
        herderView.addSubview(header)
        viewModel = BookRoomViewModel(dataSource: BookRoomDataSource())
        viewModel.delegate = self
        
      
        
        
        
        
        
        
        getImage()
        if let url = urlString {
            let urlImage = URL(string: url)!

               // Fetch Image Data
               if let data = try? Data(contentsOf: urlImage) {
                   // Create Image and Update Image View
                imageView.image = UIImage(data: data)
               }
        //    viewModel.roomImages(url: url)
         //   let urlImage = URL(string: url)
           // imageView.sd_setImage(with: urlImage, placeholderImage: UIImage(named: "")) //image = UIImage(contentsOfFile:url)
        }
      
        
        // Do any additional setup after loading the view.
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func getImage(){
        
        if  let imageString = UserDefaults.standard.getProfileImage() {
      
            if let imageView = UIImage(data: imageString) {
                print("data contains image data")
                //profileImage.image = imageView
                header.btnProfile.setImage(imageView, for: .normal)
            }
        }
    }
    func getImgData(data:Data){
        if let image = UIImage(data: data) {
            imageView.image = image
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        header.btnNotiyCount.setTitle("\(UserDefaults.standard.getNotifyCount() )", for: .normal)
        self.navigationController?.isNavigationBarHidden = true
    }
}
extension RoomPhotoVC: HeaderViewDelegate{
    func btnMenuTapped(sender: UIButton) {
        
        _ = navigationController?.popViewController(animated: true)

    }
    
    func btnProfileTapped(sender: UIButton) {
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kEmpVC, type: EmpVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func btnLogoutTapped(sender: UIButton) {
        
        let vc = Constant.getViewController(storyboard: Constant.kNotification, identifier: Constant.kNotificationVC, type: NotificationVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension RoomPhotoVC : ViewModelDelegate {
    func willLoadData() {
        startLoader()
    }
    
    func didLoadData() {
        stopLoader()
        self.getImgData(data: viewModel.imgData ?? Data ())
    }
    
    func didFail(error: CustomError) {
        stopLoader()
        showErrorMessage(title: "Error...", error: error) { (action) in
            
        }
    }
    
    
}
