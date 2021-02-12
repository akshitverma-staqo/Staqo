//
//  Extension.swift
//  
//
//  Created by apple on 27/03/19.
//  Copyright © 2019 ESoft Technologies. All rights reserved.
//


import Foundation
import UIKit


extension UINavigationBar {
    
    func setGradientBackground() {
    
        var colors:[Any] = []
        if #available(iOS 11.0, *) {
            colors = [UIColor(named: "NavGreen")?.cgColor as! CGColor, UIColor(named: "NavBlue")?.cgColor as! CGColor]
        } else {
            // Fallback on earlier versions
        }
        
        let gradient: CAGradientLayer = CAGradientLayer()
       
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        var bounds = self.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = colors;
        self.setBackgroundImage(self.image(gradientLayer: gradient), for: .default)
    }
    
   private func image(gradientLayer: CAGradientLayer) -> UIImage? {
    
    var gradientImage:UIImage?
    UIGraphicsBeginImageContext(gradientLayer.frame.size)
    if let context = UIGraphicsGetCurrentContext() {
        gradientLayer.render(in: context)
        gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
    }
    UIGraphicsEndImageContext()
    return gradientImage
    }
}
