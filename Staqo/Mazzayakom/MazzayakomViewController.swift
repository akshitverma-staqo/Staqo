////
////  BottomViewController.swift
////  ScreensDemo
////
////  Created by Neeraj Tiwari on 20/01/21.
////
//
//import UIKit
//
//class MazzayakomViewController: UIViewController {
//    
//    private var originalPullUpControllerViewSize: CGSize = .zero
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        //commonNavigationBar(controller: .bottomSwipe)
//        self.addPullUpController(animated: true)
//    }
//    
//    
//    @IBAction func backButton(_ sender: Any) {
//        
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    
//    private func addPullUpController(animated: Bool) {
//        
//        let pullUpController = makeSearchViewControllerIfNeeded()
//        
//        _ = pullUpController.view // call pullUpController.viewDidLoad()
//        
//        addPullUpController(pullUpController,
//                            
//                            initialStickyPointOffset: pullUpController.initialPointOffset,
//                            
//                            animated: animated)
//        
//    }
//    
//    private func makeSearchViewControllerIfNeeded() -> SwipeUpViewController {
//        
//        // for storyboard
//        //        self.navigationController?.pushViewController(Constant.Controllers.get(.bottomSwipe)(), animated: true)
//        let viewCont = Constant.Controllers.get(.bottomSwipe)()
//        // for .xib
//        //        let viewCont =   SwipeUpViewController(nibName: "SwipeUpViewController", bundle: nil)
//        //        viewCont.initialState = .contracted
//        return viewCont as! SwipeUpViewController
//        
//        
//    }
//}
