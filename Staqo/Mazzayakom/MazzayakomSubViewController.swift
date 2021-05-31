    //
    //  MazzayakomSubViewController.swift
    //  OQ
    //
    //  Created by Bennett University on 16/01/21.
    //
    
    import UIKit
    import Alamofire
    class MazzayakomSubViewController: UIViewController {
        
        
        @IBOutlet weak var collectionView: UICollectionView!
        
        @IBOutlet weak var tableView: UITableView!
        
        var selectedIndex = 0
        
        private let spinner = SpinnerViewController()
        
        var accessToken = ""
        var arrDara = [MazzayakomCatListModel]()
       // var arrDara1 = [MazzayakomCatURLModel]()
        var array = [""]
        var catId = ""
        var checkTableViewCount = 0
        // let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            commonNavigationBar(controller: .listing)
            setCollectionLayout()
            collectionView.delegate = self
            let itemcount = (catId as NSString).integerValue
            selectedIndex = itemcount-1
            print(selectedIndex)
            self.collectionView.scrollToItem(at:IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
            collectionView.layoutIfNeeded()
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: IndexPath(item: self.selectedIndex , section: 0), at: .centeredHorizontally, animated: true)
                self.collectionView.setNeedsLayout()
            }
          
        }
        
        func getAllUsreDataAF(){
            accessToken = UserDefaults.standard.getAccessToken()
            let headers: HTTPHeaders = [
                "Authorization": "Bearer "+accessToken+""
            ]
            let urlStr = "\(String(describing: UserDefaults.standard.string(forKey: "BASE_URL")!))\(String(describing: UserDefaults.standard.string(forKey: "MAZZAYACOM_C_SITE_ID")!))\(String(describing: UserDefaults.standard.string(forKey: "MAZZAYAKOM_SUB_CATEGORY_URL")!))\(catId)'"
            //  NetworkClient.request(url: urlStr, method: .get, parameters: nil, encoder: JSONEncoding.default, headers: headers)
            print(urlStr)
            Alamofire.request(urlStr, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    print(response)     
                    
                    if let data = response.data {
                        do{
                            
                            let json1 = try JSON(data:data)
                            let fieldsValue = json1["value"]
                            print("fieldsValue")
                            print(fieldsValue)
                            
                            self.checkTableViewCount = fieldsValue.count
                            if fieldsValue.count == 0 {
                                self.arrDara.removeAll()
                                
                                DispatchQueue.main.async{
                                    self.tableView.reloadData()
                                }
                                let alert = UIAlertController(title: "Alert",
                                                              message: "No Items.",
                                                              preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alert, animated: true)
                                
                            }else{
                                self.arrDara.removeAll()
                                for array in fieldsValue.arrayValue{
                                    self.arrDara.append(MazzayakomCatListModel(json: array["fields"]))
                                   // self.arrDara1.append(MazzayakomCatURLModel(json: array["fields"]["Link"]))
                                    print(array["fields"]["Link"])
                                    print(self.arrDara)
                                   // print(self.arrDara1)
                                    DispatchQueue.main.async{
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }catch let err{
                            print(err.localizedDescription)
                        }
                    }
                }
        }
        
        
        
        @IBAction func backButton(_ sender: Any) {

            self.dismiss(animated: true, completion: nil)
            
        }
        func setCollectionLayout()
        {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: 80, height: 33)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            layout.scrollDirection = .horizontal
            self.collectionView.reloadData()
            collectionView.collectionViewLayout = layout
     
        }
    }

    extension MazzayakomSubViewController : UITableViewDelegate, UITableViewDataSource
    {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            if checkTableViewCount == 0  {
                return 0
            }else{
                return arrDara.count
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            let titleLbl = cell.viewWithTag(1) as! UILabel
            let subTitleLbl = cell.viewWithTag(2) as! UILabel
            _ = cell.viewWithTag(3) as! UILabel
            if checkTableViewCount == 0 {
                
            }else{
                titleLbl.text = arrDara[indexPath.row].Title
                
                let subtitleDes = arrDara[indexPath.row].Description.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
                subTitleLbl.text = subtitleDes
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return 20
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.navigationController?.pushViewController(Constant1.Controllers.get(.backBottom)(), animated: true)
        }
        
        
    }
    
    
    extension MazzayakomSubViewController : UICollectionViewDelegate, UICollectionViewDataSource
    {
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
        {
            
            print("Array count@@")
            print(UserDefaults.standard.integer(forKey: "arrDaraCount"))
            return UserDefaults.standard.integer(forKey: "arrDaraCount")
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            let mainLbl = cell.viewWithTag(1) as! UILabel
            mainLbl.layer.cornerRadius = 16.5
            mainLbl.clipsToBounds = true
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "catItems") ?? [String]()
            mainLbl.text = myarray[indexPath.item]
            let catIdList  = defaults.stringArray(forKey: "catIdList") ?? [String]()
            print("You selected cell #\(indexPath.item)!")
            catId = catIdList[indexPath.row]
            if indexPath.item == selectedIndex {
                mainLbl.backgroundColor = .darkGreen
                mainLbl.textColor = .white
                getAllUsreDataAF()
                
            }else
            {
                mainLbl.backgroundColor = .lightGreen
                mainLbl.textColor = .darkGreen
            }
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            selectedIndex = indexPath.item
            collectionView.reloadData()
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 20)
        }
    }
    
    
    extension MazzayakomSubViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "catItems") ?? [String]()
            let str = myarray[indexPath.item]
            let size = str.size(withAttributes: nil)
            return CGSize(width: size.width + 50, height: 33)
            
        }
    }
    
