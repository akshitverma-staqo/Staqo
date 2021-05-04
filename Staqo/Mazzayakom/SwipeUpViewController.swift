//
//  SwipeUpViewController.swift
//  ScreensDemo
//
//  Created by Neeraj Tiwari on 20/01/21.
//

import UIKit
import PullUpController
import Alamofire

class SwipeUpViewController: PullUpController {
    
    @IBOutlet weak var tblTop: NSLayoutConstraint!
    @IBOutlet weak var lblTop: NSLayoutConstraint!
    @IBOutlet weak var lblLeading: NSLayoutConstraint!
    @IBOutlet weak var swipeUp: UILabel!
    @IBOutlet weak var tableView: UITableView!
    public var portraitSize: CGSize = .zero
    public var landscapeFrame: CGRect = .zero
    var accessToken = ""
    var arrDara = [MazzayakomCatListModel]()
    var array = [""]
    var imgName = ""
    var catId = 0
    var catItems : [String] = []
    var catIdList : [String] = []
    var imgURL = [""]
    var isExpanded = false
    var previousPoint : CGFloat = 400.0
    
    enum InitialState {
        case contracted
        case expanded
        
    }
    
    private let spinner = SpinnerViewController()
    
    var initialState: InitialState = .contracted
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        getAllUsreDataAF()
        self.tableView.attach(to: self)
        
        
    }
    var initialPointOffset: CGFloat {
        switch initialState {
        case .contracted:
            return 400
        case .expanded:
            return UIScreen.main.bounds.height - 85
        }
    }
    
    func setUI()
    {
        self.view.layer.cornerRadius = 12
        self.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        swipeUp.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    }
    
    
    override var pullUpControllerPreferredSize: CGSize {
        
        var height = CGFloat((arrDara.count )) * 400.0
        
        if height > UIScreen.main.bounds.height - 85  {
            
            height = UIScreen.main.bounds.height - 85
            
        }
        return CGSize(width: UIScreen.main.bounds.width , height: height)
    }
    
    open override var pullUpControllerMiddleStickyPoints: [CGFloat] {
        var height = CGFloat((arrDara.count )) * 400.0
        
        if height > UIScreen.main.bounds.height - 85  {
            height = UIScreen.main.bounds.height - 85
        }
        var array : [CGFloat] = []
        
        if height >= 800 {
            array.append(800)
        }else if height >= 1200{
            
            array.append(1200)
            
        }else if height >= 1600{
            
            array.append(1600)
            
        }else if height >= 2000{
            
            array.append(2000)
            
        }
        return array
    }
    
    open override func pullUpControllerWillMove(to point: CGFloat) {
        print("pullUpControllerWillMove", point)
        controlTableOnMovement(point: point)
        
    }
    open override func pullUpControllerDidMove(to point: CGFloat) {
        print("pullUpControllerDidMove", point)
        controlTableOnMovement(point: point)
        
    }
    open override func pullUpControllerDidDrag(to point: CGFloat) {
        print("pullUpControllerDidDrag", point)
        let gap = (UIScreen.main.bounds.height - 85) - 400
        let leadingGap = (self.view.frame.width/2 - 15) - 35
        self.lblLeading.constant = (((point - 400) / gap) * leadingGap) + 35
        self.lblTop.constant = -(((point - 400) / gap) * 45) - 10
        previousPoint = point
        self.view.layoutIfNeeded()
        
    }
    
    func controlTableOnMovement(point: CGFloat)
    {
        if point <= 400 {
            isExpanded = false
            self.swipeUp.isHidden = false
            self.lblLeading.constant = 35
            self.lblTop.constant = 10
            self.tblTop.constant = 10
        }else
        {
            isExpanded = true
            self.swipeUp.isHidden = true
            self.lblLeading.constant = self.view.frame.width/2 - 15
            self.lblTop.constant = -50
            self.tblTop.constant = 30
        }
        self.tableView.reloadData()
        self.view.layoutIfNeeded()
    }
    
    func getAllUsreDataAF(){
        
        accessToken = UserDefaults.standard.getAccessToken()
        print("AccessToekn+++" + accessToken)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+accessToken+""
            
        ]
        spinner.start(container: self)
        let maazycomlist = UserDefaults.standard.string(forKey: "MAZZAYACOM_LINK")
    
        let replaced = maazycomlist!.replacingOccurrences(of: "**OC_LIST_ID**", with: UserDefaults.standard.string(forKey: "MAZZAYACOM_A_LIST_ID") ?? "")
        
        let urlStr = "\(String(describing: UserDefaults.standard.string(forKey: "BASE_URL") ?? ""))\(String(describing: UserDefaults.standard.string(forKey: "MAZZAYACOM_C_SITE_IDshaily") ?? ""))\(String(describing: replaced))"
        print(urlStr)
        Alamofire.request(urlStr, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let data = response.data {
                    print(response)
                    do{
                        self.spinner.stop()
                        let json1 = try JSON(data:data)
                        let fieldsValue = json1["value"]
                        self.arrDara.removeAll()
                        for array in fieldsValue.arrayValue{
                            self.arrDara.append(MazzayakomCatListModel(json: array["fields"]))
                            let listValue = MazzayakomCatListModel(json: array["fields"])
                            print(listValue.name)
                            
                        }
                        
                    }catch let err{
                        print(err.localizedDescription)
                        self.spinner.stop()
                    }
                }
            }
    }
    
}

extension SwipeUpViewController : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isExpanded == false{
            return 1;
        }else{
            print(arrDara.count)
        }
        
        return arrDara.count
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MazzayakomSubViewController") as? MazzayakomSubViewController
        vc!.catId = arrDara[indexPath.row].id
        let defaults = UserDefaults.standard
        defaults.set(catItems, forKey: "catItems")
        print(catItems.count)
        defaults.set(catIdList, forKey: "catIdList")
        defaults.set(arrDara.count, forKey: "arrDaraCount")
        present(vc!, animated: true, completion: nil)
   


    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if isExpanded == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            return cell
        }else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BottomlistCell", for: indexPath)
            let lbl = cell.viewWithTag(1) as! UILabel
            let lblDes = cell.viewWithTag(4) as! UILabel
            let bgView = cell.viewWithTag(2) as! UIView
            let imgView = cell.viewWithTag(3) as! UIImageView
            bgView.layer.cornerRadius = 15
            bgView.applyShadowWithCornerRadius(color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), opacity: 1, radius: 10, edge: AIEdge.All, shadowSpace: 0)
            lbl.text = arrDara[indexPath.row].name
            lblDes.text = arrDara[indexPath.row].description
            
            catItems.append(arrDara[indexPath.row].name)
            catIdList.append(arrDara[indexPath.row].id)
            let jsonText = arrDara[indexPath.row].icon_image
            var dictonary:NSDictionary?
            
            if let data = jsonText.data(using: String.Encoding.utf8) {
                do {
                    dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                    
                    if let myDictionary = dictonary
                    {
                        print("First name is: \(myDictionary["fileName"]!)")
                        print(imgName)
                        let imagStrUrl = (myDictionary["fileName"]!)
                        print(imagStrUrl)
                        var downloadURL = ""
                        accessToken = UserDefaults.standard.getAccessToken()
                        print("AccessToekn+++" + accessToken)
                        
                        let headers: HTTPHeaders = [
                            "Authorization": "Bearer "+accessToken+""
                            
                        ]
                        let urlMazz = UserDefaults.standard.string(forKey: "MAZZAYACOM_IMAGE_LINK")
                        let replaced = urlMazz!.replacingOccurrences(of: "**Assests_ID**", with: UserDefaults.standard.string(forKey: "MAZZAYACOM_ASSET_ID") ?? "").replacingOccurrences(of: "**A_list_ID**", with: UserDefaults.standard.string(forKey: "MAZZAYACOM_A_LIST_ID") ?? "")
                        
                        print(UserDefaults.standard.string(forKey: "MAZZAYACOM_C_LIST_ID") ?? "")
                        
                        let urlStr = "\(String(describing: UserDefaults.standard.string(forKey: "BASE_URL")!))\(String(describing: UserDefaults.standard.string(forKey: "MAZZAYACOM_C_SITE_ID")!))\(String(describing: replaced))\(imagStrUrl)"
                        print(urlStr)
                        Alamofire.request(urlStr, encoding: JSONEncoding.default, headers: headers)
                            .responseJSON { response in
                                print(response)
                                //to get status code
                                
                                if let data = response.data {
                                    do{
                                        let json1 = try JSON(data:data)
                                        downloadURL = json1["@microsoft.graph.downloadUrl"].stringValue
                                        print("URL ITHNK" + downloadURL)
                                        Alamofire.request(downloadURL)
                                            .response { response in
                                                print("Response value")
                                                print(response)
                                                if let data = response.data {
                                                    do{
                                                        imgView.image = UIImage(data: data)
                                                    }
                                                }
                                            }
            
                                    }catch let err{
                                        print(err.localizedDescription)
                                    }
                                }
                            }
                    }
                }
                catch let error as NSError {
                    print(error)
                }
            }
            return cell
        }
    }
}
extension UIView {
    
    func applyShadowWithCornerRadius(color:UIColor, opacity:Float, radius: CGFloat, edge:AIEdge, shadowSpace:CGFloat)    {
        
        var sizeOffset:CGSize = CGSize.zero
        switch edge {
        case .Top:
            sizeOffset = CGSize(width: 0, height: -shadowSpace)
        case .Left:
            sizeOffset = CGSize(width: -shadowSpace, height: 0)
        case .Bottom:
            sizeOffset = CGSize(width: 0, height: shadowSpace)
        case .Right:
            sizeOffset = CGSize(width: shadowSpace, height: 0)
        case .Top_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: -shadowSpace)
        case .Top_Right:
            sizeOffset = CGSize(width: shadowSpace, height: -shadowSpace)
        case .Bottom_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: shadowSpace)
        case .Bottom_Right:
            sizeOffset = CGSize(width: shadowSpace, height: shadowSpace)
            
            
        case .All:
            sizeOffset = CGSize(width: 0, height: 0)
        case .None:
            sizeOffset = CGSize.zero
        }
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true;
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = sizeOffset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath
    }
}

enum AIEdge:Int {
    case
        Top,
        Left,
        Bottom,
        Right,
        Top_Left,
        Top_Right,
        Bottom_Left,
        Bottom_Right,
        All,
        None
}
