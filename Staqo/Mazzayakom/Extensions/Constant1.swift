

import Foundation
import UIKit

class Constant1: NSObject {
    
    //MARK:- STORYBOARDS
    public struct Storyboards
    {
        static let main = UIStoryboard(name: "Main", bundle: nil)
       
    }
    
    //MARK:- ViewControllers
    public enum Controllers {
        case dashboard
        case listing
        case backBottom
        case bottomSwipe
        case saveContact

       
        
        func get()->UIViewController{
            switch self {
                
            case .dashboard:
              
                return Storyboards.main.instantiateViewController(withIdentifier: "WelcomeViewController")
                
            case .listing:
                return Storyboards.main.instantiateViewController(withIdentifier: "ListingViewController")
                
            case .backBottom:
                return Storyboards.main.instantiateViewController(withIdentifier: "BottomViewController")
                
            case .bottomSwipe:
                let vc = Constant.getViewController(storyboard: Constant.kMazzaykomStoryboard, identifier:Constant.kSwipeControllerVC, type:SwipeUpViewController.self )
                return vc
                
            case .saveContact:
                
                return Storyboards.main.instantiateViewController(withIdentifier: "SaveContactViewController")
           
            }
        }
    }
    
}
