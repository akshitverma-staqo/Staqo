//
//  ANActivityIndicatorAnimationBallScale.swift
//  ANActivityIndicatorViewDemo
//
//  Created by Nguyen Vinh on 7/24/15.
//  Copyright (c) 2015 Nguyen Vinh. All rights reserved.
//

import UIKit


class ANActivityIndicatorAnimationBallScale: ANActivityIndicatorAnimation {
    required init() {
        
    }
    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        let duration: CFTimeInterval = 1
        
        // Scale animation
        let scaleAnimation = CABasicAnimation(keyPath:"transform.scale")
        
        scaleAnimation.duration = duration;
        scaleAnimation.fromValue = 0;
        scaleAnimation.toValue = 1;
        
        // Opacity animation
        let opacityAnimation = CABasicAnimation(keyPath:"opacity")
        
        opacityAnimation.duration = duration;
        opacityAnimation.fromValue = 1;
        opacityAnimation.toValue = 0
        
        // Animation
        let animation = CAAnimationGroup()
        
        animation.animations = [scaleAnimation, opacityAnimation];
      animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        // Draw circle
        let circle = ANActivityIndicatorShape.circle.layerWith(size: size, color: color)
        
        circle.frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                              y: (layer.bounds.size.height - size.height) / 2,
                              width: size.width,
                              height: size.height);
        circle.add(animation, forKey: "animation")
        layer.addSublayer(circle)
    }
}