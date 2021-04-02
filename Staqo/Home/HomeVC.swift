//
//  HomeVC.swift
//  Staqo
//
//  Created by SHAILY on 18/02/21.
//

import UIKit

class HomeVC: BaseVC {
    
    @IBOutlet weak var herderView: HeaderView!
    
    var header:HeaderView!
    var viewModel:HomeViewModal!
    var viewModelNotify: NotificationViewModel!
    var menuFlag:Bool = true
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet var currentPage: UIPageControl!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    @IBOutlet weak var notificationCountBar: UIBarButtonItem!
    @IBOutlet weak var gridCollectionView: UICollectionView!
    @IBOutlet weak var gridView: UIView!
    private let kHomeCollectionViewCell = "HomeCollectionViewCell"
    private let kHomeMenuCollectionViewCell = "HomeMenuCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:70))
        header.delegate = self
       
        herderView.addSubview(header)
        viewModel = HomeViewModal(dataSource: HomeDataSource())
        viewModel.delegate = self
        viewModel.bootstrap()
        
        viewModelNotify = NotificationViewModel(dataSource: NotificationDataSource())
        viewModelNotify.delegateNotify = self
        
       let value =  UserDefaults.standard.setMenuStatus()
        if value {
            menuFlag = true
            gridView.isHidden = true
            self.getCarousalView()
            UserDefaults.standard.setMenuValue(value: menuFlag)
        }else{
            menuFlag = false
            gridView.isHidden = false
            UserDefaults.standard.setMenuValue(value: menuFlag)
            gridCollectionView.reloadData()
        }
        
    
        homeCollectionView.register(UINib(nibName: kHomeCollectionViewCell, bundle: Bundle.main), forCellWithReuseIdentifier: kHomeCollectionViewCell)
        gridCollectionView.register(UINib(nibName: kHomeMenuCollectionViewCell, bundle: Bundle.main), forCellWithReuseIdentifier: kHomeMenuCollectionViewCell)
    
        // Do any additional setup after loading the view.
    }
    func getCarousalView() {
        let floawLayout = UPCarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: homeCollectionView.frame.size.height - 50.0)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0.8
        floawLayout.sideItemAlpha = 1.0
        floawLayout.spacingMode = .fixed(spacing: 10.0)
        homeCollectionView.collectionViewLayout = floawLayout
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        viewModelNotify.bootstrap()
        self.navigationController?.isNavigationBarHidden = true
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.homeCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage.currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
   
    fileprivate var pageSize: CGSize {
        let layout = self.homeCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    @IBAction func changeMenuTap(_ sender: Any) {
        if menuFlag {
            menuFlag = false
            gridView.isHidden = false
            UserDefaults.standard.setMenuValue(value: menuFlag)
            gridCollectionView.reloadData()
            
        }else{
            menuFlag = true
            gridView.isHidden = true
            homeCollectionView.reloadData()
            self.getCarousalView()
            currentPage.currentPage = 0
            UserDefaults.standard.setMenuValue(value: menuFlag)

        }
    }
    
    @IBAction func NotificationViewTap(_ sender: UIBarButtonItem) {

        let vc = Constant.getViewController(storyboard: Constant.kNotification, identifier: Constant.kNotificationVC, type: NotificationVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
        

    }
    @IBAction func MenuPageTap(_ sender: UIBarButtonItem) {
        
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kMenuVC, type: MenuVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
 

}
extension HomeVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.rows?.imageArr.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if menuFlag {
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: kHomeCollectionViewCell, for: indexPath) as! HomeCollectionViewCell
            cell.dataBind(data: viewModel.rows, index: indexPath)
            return cell

        }else{
            let cell = gridCollectionView.dequeueReusableCell(withReuseIdentifier: kHomeMenuCollectionViewCell, for: indexPath) as! HomeMenuCollectionViewCell
            cell.dataBind(data: viewModel.rows, index: indexPath)
            return cell

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kWebViewVC, type: WebViewVC.self)
       
        
        print("You selected cell #\(indexPath.row)!")
        
        switch indexPath.row {
        case 0:
        
            let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kWebViewVC, type: WebViewVC.self)

            self.navigationController?.pushViewController(vc, animated: true)
            
            
        case 1:
          
            let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kEmpVC, type: EmpVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        case 2:
           
            let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kEmpVC, type: EmpVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3:

            let vc = Constant.getViewController(storyboard: Constant.kBusinessStoryboard, identifier: Constant.kBusinessVC, type: BusinessVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
       
        
        case 4:
            print("Helpdesk")
            let vc = Constant.getViewController(storyboard: Constant.kHelpDesk, identifier: Constant.kHelpDeskVC, type: HelpDeskVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
           
        case 5:
            
            print("IHSEE")
            
            guard let url = URL(string: "intelex://")else{
                
                return
            }

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                print(url)
            }else{
                UIApplication.shared.open(URL(string: "https://apps.apple.com/us/app/intelex-mobile/id1097232446")!)
            }

        case 6:
            print("ESIGN")
            guard let url = URL(string: "signnow-private-cloud://sso_login?refresh_token=" + (UserDefaults.standard.getAccessToken()) + "&access_token=" + (UserDefaults.standard.getAccessToken()) + "&hostname=" + "esign.oq.com")else{
                
                return
            }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                print(url)
            }else{
                UIApplication.shared.open(URL(string: "https://apps.apple.com/us/app/signnow-private-cloud/id1491162399")!)
            }

        case 7:
            print("Travel & leave request")
           

     
        case 8:
           print("Majalish")
            let vc = Constant.getViewController(storyboard: Constant.kRoom, identifier: Constant.kRoomBookMainVC, type: RoomBookMainVC.self)
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc, animated: true)

        default:
            print("Nothing")
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if menuFlag {
            return  CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: homeCollectionView.frame.size.height - 50.0)

        }else{
            return CGSize(width: gridCollectionView.bounds.size.width/3.2, height: gridCollectionView.bounds.size.height/4)
        }
    }
}
extension HomeVC: ViewModelDelegate{
    func willLoadData() {
        startLoader()

    }
    
    func didLoadData() {
        
        stopLoader()
       
        
        //userLbl.text = UserDefaults.standard.getProfile()?.displayName
        homeCollectionView.reloadData()
        //currentPage.currentPage = viewModel.rows?.imageArr.count ?? 0
        currentPage.numberOfPages = viewModel.rows?.imageArr.count ?? 0
        
    }
    
    func didFail(error: CustomError) {
        showErrorMessage(title: "Error", error: error) { (action) in
            
        }
        stopLoader()
    }
    
    
}

extension HomeVC: HeaderViewDelegate{
    func btnMenuTapped(sender: UIButton) {
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kMenuVC, type: MenuVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
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
extension HomeVC : GetNotifyCountDelegate{
    func getNotifyCount() {
      let value = viewModelNotify.rows?.filter{!($0.fields?.isRead ?? false)}
        header.btnNotiyCount.setTitle("\(value?.count ?? 0)", for: .normal)
    }
    
    
}
