
import UIKit



extension UIColor {
    static var appPink : UIColor {
        
         
        return UIColor(red: 255/255, green: 58/255, blue: 121/255, alpha: 1)

    }
  
    static var darkGreen : UIColor {
        
         
        return UIColor(red: 39/255, green: 173/255, blue: 183/255, alpha: 1)

    }
    
    static var lightGreen : UIColor {
        
         
        return UIColor(red: 211/255, green: 239/255, blue: 241/255, alpha: 1)

    }
    
    static var checkGrey : UIColor {
        
         
        return UIColor(red: 237/255, green: 237/255, blue: 239/255, alpha: 1)

    }
    
   
}

struct AppFontName {
  static let bold = "Century Gothic 400"
  
    static let regular = "Century Gothic"
   
    
}




extension UIFont {
    
    static var smallFont: UIFont {
        return UIFont(name: AppFontName.bold, size: 15)!
    }
    static var appTitle: UIFont {
        return UIFont(name: AppFontName.regular, size: 15)!
    }

}

    
   




