//
//  HomeVC.swift
//  Staqo
//
//  Created by SHAILY on 18/02/21.
//

import UIKit
import Alamofire
class HomeVC: BaseVC {
    
    @IBOutlet weak var herderView: HeaderView!
    
    var header:HeaderView!
    var viewModel:HomeViewModal!
    var viewModelNotify: NotificationViewModel!
    var empViewModel:EmpViewModal!
    var menuFlag:Bool = true
    @IBOutlet weak var menuBtnTap: UIButton!
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
        somemazaycomAPI()
        herderView.addSubview(header)
        viewModelNotify = NotificationViewModel(dataSource: NotificationDataSource())
        viewModelNotify.delegateNotify = self
               
        viewModel = HomeViewModal(dataSource: HomeDataSource())
        viewModel.delegate = self
        viewModel._delegate = self
        viewModel.bootstrap()
       
        empViewModel = EmpViewModal(dataSource: EmpDataSource())
        empViewModel.empDelegate = self
        
            homeCollectionView.register(UINib(nibName: kHomeCollectionViewCell, bundle: Bundle.main), forCellWithReuseIdentifier: kHomeCollectionViewCell)
            gridCollectionView.register(UINib(nibName: kHomeMenuCollectionViewCell, bundle: Bundle.main), forCellWithReuseIdentifier: kHomeMenuCollectionViewCell)
        
     
       let value =  UserDefaults.standard.setMenuStatus()
        if value {
            menuFlag = true
            gridView.isHidden = true
            menuBtnTap.setImage(UIImage(named: "dashmenu.png"), for: .normal)

            self.getCarousalView()
            UserDefaults.standard.setMenuValue(value: menuFlag)
        }else{
            menuFlag = false
            gridView.isHidden = false
            menuBtnTap.setImage(UIImage(named: "dashmenuflip.png"), for: .normal)
            UserDefaults.standard.setMenuValue(value: menuFlag)
            gridCollectionView.reloadData()
        }
        
}
    
    func getImage(){
        
        if  let imageString = UserDefaults.standard.getProfileImage() {
      
            if let imageView = UIImage(data: imageString) {
                print("data contains image data")
                header.btnProfile.setImage(imageView, for: .normal)
            }
        }else{
            header.btnProfile.setImage(UIImage(named:"profiled"), for: .normal)
        }
      
//        var downloadPath = FileSystem.downloadDirectory
//        downloadPath.appendPathComponent("profile")
//        if FileManager().fileExists(atPath: downloadPath.path){
//            if let image = UIImage(contentsOfFile: downloadPath.path) {
//                herderView.btnProfile.setImage(image, for: .normal)
//            }
//        }
       
    }
    
    
    func getProfileImg(){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+UserDefaults.standard.getAccessToken()+""
            
        ]

        let urlStr = "https://graph.microsoft.com/v1.0/me/photo/$value"
        //NetworkClient.request(url: urlStr, method: .post, parameters: nil, headers: headers)
        Alamofire.request(urlStr, headers: headers)
            .response { [self] response in
                if let data = response.data {
                    do{

                        if let imageView = UIImage(data: data) {
                            print("data contains image data")
                     //       herderView.btnProfile.imageView?.image = imageview
                            header.btnProfile.setImage(imageView, for: .normal)
                         //   self.profileImage.image = UIImage(data: data)
                        } else {
                            print("data does not contain image data")
                           // self.profileImage.image = UIImage(named:"profiled.png")
                        }
                          
                    }
                }
            }
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
        if (UserDefaults.standard.getProfile()?.email) != nil {
            viewModelNotify.bootstrap()
            self.empViewModel.bootstrap()
         //   self.empViewModel.bootstrap()
        }
        
        self.navigationController?.isNavigationBarHidden = true
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if menuFlag {
             
            let layout = self.homeCollectionView.collectionViewLayout as! UPCarouselFlowLayout
            let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
            let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
            currentPage.currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)

         }else{
           
         }
       
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
            menuBtnTap.setImage(UIImage(named: "dashmenuflip.png"), for: .normal)

            UserDefaults.standard.setMenuValue(value: menuFlag)
            gridCollectionView.reloadData()
            
        }else{
            menuFlag = true
            gridView.isHidden = true
            menuBtnTap.setImage(UIImage(named: "dashmenu.png"), for: .normal)
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
    
    
    func somemazaycomAPI(){
        ////////
        
        let BASE_URL = "https://graph.microsoft.com/v1.0/sites/"
        UserDefaults.standard.set(BASE_URL, forKey: "BASE_URL")
        
        let NOTIFICATION_URL = "/lists/Notifications/items?$expand=fields"
        UserDefaults.standard.set(NOTIFICATION_URL, forKey: "NOTIFICATION_URL")
        
          
        
        let VISITOR_LIST = "/lists/Visitor%20Master/items/?$expand=fields&$filter=fields/employeeidLookupId%20eq%20'**empid**'%20or%20fields/scanby%20eq%20'1'%20"
        UserDefaults.standard.set(VISITOR_LIST, forKey: "VISITOR_LIST")
        
        let VISITOR_REGISTER = "/lists/Visitor%20Master/items"
        UserDefaults.standard.set(VISITOR_REGISTER, forKey: "VISITOR_REGISTER")
        
        let SALMEEN_POINT1 = URL(string:"https://thisisoq.sharepoint.com/Pages/Salmeen.aspx")
        UserDefaults.standard.set(SALMEEN_POINT1, forKey: "SALMEEN_POINT1")
        
        let SALMEEN_POINT2 = URL(string:"https://oq.com/en/covid-19/declaration-employees")
        UserDefaults.standard.set(SALMEEN_POINT2, forKey: "SALMEEN_POINT2")
        
        let USER_PIC_FROMAD = "https://graph.microsoft.com/v1.0/users/**useremail**/photo/$value"
        UserDefaults.standard.set(USER_PIC_FROMAD, forKey: "USER_PIC_FROMAD")
        
        let EMPLOYEE_FOR_ID = "/lists/Employee%20Master/items/?$expand=fields&$filter=fields/emailid%20eq%20'"
        UserDefaults.standard.set(EMPLOYEE_FOR_ID, forKey: "EMPLOYEE_FOR_ID")
        
        let EMPLOYEE_FIND_BY_ID = "/lists/Employee%20Master/items/"
        UserDefaults.standard.set(EMPLOYEE_FIND_BY_ID, forKey: "EMPLOYEE_FIND_BY_ID")
        
        let EMPLOYEE_REGISTER =  "/lists/Employee%20Master/items"
        UserDefaults.standard.set(EMPLOYEE_REGISTER, forKey: "EMPLOYEE_REGISTER")
        
      //  let MAZZAYAKOM_MAIN_URL = "/lists/Category_Master/items?expand=fields"
      //  UserDefaults.standard.set(MAZZAYAKOM_MAIN_URL, forKey: "MAZZAYAKOM_MAIN_URL")
        
        let MAZZAYAKOM_SUB_CATEGORY_URL =  "/lists/Corporate_Offers/items/?$expand=fields&$filter=fields/CategoryLookupId%20eq%20'"
        UserDefaults.standard.set(MAZZAYAKOM_SUB_CATEGORY_URL, forKey: "MAZZAYAKOM_SUB_CATEGORY_URL")
        
        let VISITOR_DUPLICATE =  "/lists/Visitor%20Master/items?$expand=fields&$filter=fields/emailid%20eq%20'**email**'%20and%20fields/scanby%20eq%20'1'%20"
        UserDefaults.standard.set(VISITOR_DUPLICATE, forKey: "VISITOR_DUPLICATE")

            //Live Credentials
        let OQPORTAL_LINK = URL(string:"https://thisisoq.sharepoint.com")
        //let OQPORTAL_LINK = "https://thisisoq.sharepoint.com"
        UserDefaults.standard.set(OQPORTAL_LINK, forKey: "OQPORTAL_LINK")
        
        
        
        
        
        let MAZZAYACOM_LINK =  "/lists/**OC_LIST_ID**/items?expand=fields"
        UserDefaults.standard.set(MAZZAYACOM_LINK, forKey: "MAZZAYACOM_LINK")
        
        let MAZZAYACOM_SUB_LINK =  "/lists/**C_list_id**/items?expand=fields(select=CategoryLookupId,Title,Caption)&$filter=fields/CategoryLookupId%20eq%20'"
        UserDefaults.standard.set(MAZZAYACOM_SUB_LINK, forKey: "MAZZAYACOM_SUB_LINK")
        
        let MAZZAYACOM_IMAGE_LINK =  "/drives/**Assests_ID**/root:/lists/**A_list_ID**/"
        UserDefaults.standard.set(MAZZAYACOM_IMAGE_LINK, forKey: "MAZZAYACOM_IMAGE_LINK")
        
        
   //  Local
        
       //         let SITE_ID = "544d5eca-671c-4f65-9dbe-7d4b50b02b9c"
        //        UserDefaults.standard.set(SITE_ID, forKey: "SITE_ID")

//                let MAZZAYACOM_C_LIST_ID =  "a9aa5be4-4b8d-487d-ae72-839a1de9ba13"
//                UserDefaults.standard.set(MAZZAYACOM_C_LIST_ID, forKey: "MAZZAYACOM_C_LIST_ID")
//
//                let MAZZAYACOM_ASSET_ID =  "b!yl5NVBxnZU-dvn1LULArnLdQ9qy4h6RMivIbCnyeHmVmO87f0Pt3SaG3WIEXWwfC"
//                UserDefaults.standard.set(MAZZAYACOM_ASSET_ID, forKey: "MAZZAYACOM_ASSET_ID")
//
//                let MAZZAYACOM_C_SITE_ID = "544d5eca-671c-4f65-9dbe-7d4b50b02b9c"
//                UserDefaults.standard.set(MAZZAYACOM_C_SITE_ID, forKey: "MAZZAYACOM_C_SITE_ID")
//
//
//                let MAZZAYACOM_A_LIST_ID = "2fecd167-6659-4906-b8cc-8d06047056de"
//                UserDefaults.standard.set(MAZZAYACOM_A_LIST_ID, forKey: "MAZZAYACOM_A_LIST_ID")
       
        
        //  Live
        let MAZZAYACOM_C_SITE_ID = "9267b16d-b59f-4aaa-998c-c81bdea24279"
        UserDefaults.standard.set(MAZZAYACOM_C_SITE_ID, forKey: "MAZZAYACOM_C_SITE_ID")
        
        let MAZZAYACOM_C_LIST_ID =  "35eec527-6587-458c-a35f-dd06e8e79487"
        UserDefaults.standard.set(MAZZAYACOM_C_LIST_ID, forKey: "MAZZAYACOM_C_LIST_ID")

        
        let MAZZAYACOM_ASSET_ID =  "b!bbFnkp-1qkqZjMgb3qJCeTz4E1V1WUFLoF8xgKa1gCLpyFwaggbeRIZdZ0UUm0sz"
        UserDefaults.standard.set(MAZZAYACOM_ASSET_ID, forKey: "MAZZAYACOM_ASSET_ID")
        
        let SITE_ID = "347d2bb7-7c8d-4d31-8d34-783763ab8ccb"
        UserDefaults.standard.set(SITE_ID, forKey: "SITE_ID")
        
        //https://graph.microsoft.com/v1.0/sites/9267b16d-b59f-4aaa-998c-c81bdea24279/lists/35eec527-6587-458c-a35f-dd06e8e79487/items?expand=fields";
       // ApplicationConstant.BASE_URL+
//                                ApplicationConstant.MAZZAYACOM_C_SITE_ID +
//                                ApplicationConstant.MAZZAYACOM_LINK
//                                        .replace("*OC_LIST_ID*",ApplicationConstant.MAZZAYACOM_OC_LIST_ID),
//        
        //Live Credentials
//          public static final String OQPORTAL_LINK = "https://thisisoq.sharepoint.com";
//          public static final String MAZZAYACOM_LINK = "/lists/**OC_LIST_ID**/items?expand=fields";
//          public static final String MAZZAYACOM_SUB_LINK = "/lists/**C_list_id**/items?expand=fields(select=CategoryLookupId,Title,Caption)&$filter=fields/CategoryLookupId eq '";
//          public static final String MAZZAYACOM_IMAGE_LINK = "/drives/**Assests_ID**/root:/lists/**A_list_ID**/";
//          public static final String SITE_ID = "347d2bb7-7c8d-4d31-8d34-783763ab8ccb";
//          public static final String MAZZAYACOM_C_LIST_ID = "a9aa5be4-4b8d-487d-ae72-839a1de9ba13";
//          public static final String MAZZAYACOM_C_SITE_ID = "9267b16d-b59f-4aaa-998c-c81bdea24279";
//          public static final String MAZZAYACOM_OC_LIST_ID = "35eec527-6587-458c-a35f-dd06e8e79487";
//          public static final String MAZZAYACOM_ASSET_ID = "b!bbFnkp-1qkqZjMgb3qJCeTz4E1V1WUFLoF8xgKa1gCLpyFwaggbeRIZdZ0UUm0sz";
//          public static final String MAZZAYACOM_A_LIST_ID = "35eec527-6587-458c-a35f-dd06e8e79487";
//
        

//        let MAZZAYACOM_C_SITE_ID = "347d2bb7-7c8d-4d31-8d34-783763ab8ccb"
//        UserDefaults.standard.set(SITE_ID, forKey: "SITE_ID")


    }
 

}
extension HomeVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.rows?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if menuFlag {
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: kHomeCollectionViewCell, for: indexPath) as! HomeCollectionViewCell
           cell.dataBind(index: indexPath, data: viewModel.rows)
        
            return cell

        }else{
            let cell = gridCollectionView.dequeueReusableCell(withReuseIdentifier: kHomeMenuCollectionViewCell, for: indexPath) as! HomeMenuCollectionViewCell
                cell.dataBind(index: indexPath, data: viewModel.rows)
            return cell

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kWebViewVC, type: WebViewVC.self)
       
        print("You selected cell #\(indexPath.row)!")
        
        switch viewModel.rows?[indexPath.row].title ?? "" {
        case "1":
        
            UserDefaults.standard.setWebStatus(value: "U")
            UserDefaults.standard.set("oqportal", forKey: "webcheck")
            //UserDefaults.standard.setWebStatus(value: "")
            //            UserDefaults.standard.getWebStatus()
            
            let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kWebViewVC, type: WebViewVC.self)

            self.navigationController?.pushViewController(vc, animated: true)
            
            
        case "2":
            UserDefaults.standard.setWebStatus(value: "U")
            let vc = Constant.getViewController(storyboard: Constant.kMazzaykomStoryboard, identifier: Constant.kMazzayakomViewControllerVC, type: MazzayakomViewController.self)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "3":
            UserDefaults.standard.setWebStatus(value: "U")
            let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kSalmeenVC, type: SalmeenViewController.self)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "4":
            UserDefaults.standard.setWebStatus(value: "U")
            let vc = Constant.getViewController(storyboard: Constant.kBusinessStoryboard, identifier: Constant.kBusinessVC, type: BusinessVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
       
        
        case "5":
            print("Helpdesk")
            UserDefaults.standard.setWebStatus(value: "U")
            let vc = Constant.getViewController(storyboard: Constant.kHDStroyboard, identifier: Constant.kHelpDeskVC, type: HelpDeskVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
           
        case "6":
            
            print("IHSEE")
            UserDefaults.standard.setWebStatus(value: "U")
            guard let url = URL(string: "intelex://")else{
                
                return
            }

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                print(url)
            }else{
                UIApplication.shared.open(URL(string: "https://apps.apple.com/us/app/intelex-mobile/id1097232446")!)
            }

        case "7":
            print("ESIGN")
            UserDefaults.standard.setWebStatus(value: "U")
            //guard let url = URL(string: "signnow-private-cloud://sso_login?refresh_token=" + (UserDefaults.standard.getAccessToken()) + "&access_token=" + (UserDefaults.standard.getAccessToken()) + "&hostname=" + "esign.oq.com")else{https://esign.oq.com/webapp/login-sso
            guard let url = URL(string: "signnow://")else{
            //guard let url = URL(string: "signnow-private-cloud://sso_login?access_token="+UserDefaults.standard.getAccessToken() + "&hostname=esign.oq.com")else{
                return
            }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                print(url)
            }else{
                UIApplication.shared.open(URL(string: "https://apps.apple.com/us/app/signnow-private-cloud/id1491162399")!)
            }

        case "8":
            print("Travel & leave request")
           

     
        case "9":
           print("Majalish")
            UserDefaults.standard.setWebStatus(value: "U")
            let vc = Constant.getViewController(storyboard: Constant.kRoomStroyboard, identifier: Constant.kRoomBookMainVC, type: RoomBookMainVC.self)
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "10":
           print("ApproveStatus")
        
            
                UserDefaults.standard.setWebStatus(value: "A")
            
             let vc = Constant.getViewController(storyboard: Constant.kRoomStroyboard, identifier: Constant.kApproveCancelVC, type: ApproveCancelVC.self)
             self.navigationController?.isNavigationBarHidden = true
             self.navigationController?.pushViewController(vc, animated: true)

        case "11":
           print("OQ Roadshow")
            UserDefaults.standard.set("roadshow", forKey: "webcheck")
            let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kWebViewVC, type: WebViewVC.self)
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
        if (UserDefaults.standard.getProfile()?.email) != nil {
            viewModelNotify.bootstrap()
        }
        
       
        currentPage.numberOfPages = viewModel.rows?.count ?? 0
        
        userLbl.text = UserDefaults.standard.getProfile()?.name
        
        homeCollectionView.reloadData()
        gridCollectionView.reloadData()
        //currentPage.currentPage = viewModel.rows?.imageArr.count ?? 0
        
        
    }
    
    func didFail(error: CustomError) {
        
        showErrorMessage(title: "Error", error: error) { (action) in
            if error.localizedDescription.contains("401 Unauthorized") {
                print("401")
                self.showMessage(title: "", message: CustomError.Logout.localizedDescription, btnConfirmTitle:"YES", btnCancelTitle: "NO") { (isYes, action) in
                    if isYes {
                        let vc = Constant.getViewController(storyboard: Constant.kMainStoryboard, identifier: Constant.kLoginVC, type: LoginVC.self)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
           
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
    // stopLoader()
        header.btnNotiyCount.setTitle("\(UserDefaults.standard.getNotifyCount() )", for: .normal)
    }
    
    
}
extension HomeVC:EmpRefreshDelegate{
    func getRefresh() {
    //    stopLoader()
        //self.viewModel.dashboardData()
    }
    
}
extension HomeVC : HomeViewModalDelegate{
    func callImage() {
        self.getImage()
    }
}

