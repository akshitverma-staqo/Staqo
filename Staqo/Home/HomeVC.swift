//
//  HomeVC.swift
//  Staqo
//
//  Created by SHAILY on 18/02/21.
//

import UIKit

class HomeVC: BaseVC {
    
    var viewModel:HomeViewModal!

    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    private let kHomeCollectionViewCell = "HomeCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModal(dataSource: HomeDataSource())
        viewModel.delegate = self
        viewModel.bootstrap()
        homeCollectionView.register(UINib(nibName: kHomeCollectionViewCell, bundle: Bundle.main), forCellWithReuseIdentifier: kHomeCollectionViewCell)       // Do any additional setup after loading the view.
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
extension HomeVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width/1.2, height: collectionView.bounds.size.height)//CGSize(width: 230, height: 230)
           }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.rows?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHomeCollectionViewCell, for: indexPath) as! HomeCollectionViewCell
//        cell.imgView1.image = UIImage(named: imageArr[indexPath.item])
//        cell.imgView2.image = UIImage(named: curveArr[indexPath.item])
//        cell.lbl1.text = TopLabArray[indexPath.item]
        
        return cell
        
    }
    
    
}
extension HomeVC: ViewModelDelegate{
    func willLoadData() {
        startLoader()

    }
    
    func didLoadData() {
        stopLoader()
        homeCollectionView.reloadData()
    }
    
    func didFail(error: CustomError) {
        showErrorMessage(title: "Error", error: error) { (action) in
            
        }
        stopLoader()
    }
    
    
}
