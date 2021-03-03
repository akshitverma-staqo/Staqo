//
//  HomeVC.swift
//  Staqo
//
//  Created by SHAILY on 18/02/21.
//

import UIKit

class HomeVC: BaseVC {
    
    var viewModel:HomeViewModal!

    @IBOutlet var currentPage: UIPageControl!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    private let kHomeCollectionViewCell = "HomeCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModal(dataSource: HomeDataSource())
        viewModel.delegate = self
        viewModel.bootstrap()
        homeCollectionView.register(UINib(nibName: kHomeCollectionViewCell, bundle: Bundle.main), forCellWithReuseIdentifier: kHomeCollectionViewCell)
        let floawLayout = UPCarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: homeCollectionView.frame.size.height)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0.8
        floawLayout.sideItemAlpha = 1.0
        floawLayout.spacingMode = .fixed(spacing: 10.0)
        homeCollectionView.collectionViewLayout = floawLayout
        // Do any additional setup after loading the view.
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.rows?.imageArr.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHomeCollectionViewCell, for: indexPath) as! HomeCollectionViewCell
        cell.dataBind(data: viewModel.rows, index: indexPath)

        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kWebViewVC, type: WebViewVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension HomeVC: ViewModelDelegate{
    func willLoadData() {
        startLoader()

    }
    
    func didLoadData() {
        stopLoader()
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
