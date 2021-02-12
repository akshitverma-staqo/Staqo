//
//  DesignableButton.swift
//  TharTrack
//
//  Created by esoftuser2 on 28/12/19.
//  Copyright © 2019 Esoft. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class DesignableButton: UIButton {
    
    @IBInspectable var CornerRadius :CGFloat = 0 {
        didSet {
            layer.cornerRadius = self.CornerRadius
        }
    }
    @IBInspectable var ShadowRadius: CGFloat = 0 {
    didSet {
        layer.shadowRadius = self.ShadowRadius
    }
    }
    @IBInspectable var ShadowOpacity: Float = 0 {
         didSet {
            layer.shadowOpacity = self.ShadowOpacity
         }
      }
    @IBInspectable var BorderWidth : CGFloat = 0 {
           didSet {
               layer.borderWidth = self.BorderWidth
           }
       }
       
       @IBInspectable var BorderColor : UIColor? {
              didSet {
               layer.borderColor = self.BorderColor?.cgColor
              }
          }
}

@IBDesignable class DesignableTextField: UITextField {
    
    @IBInspectable var CornerRadius :CGFloat = 0 {
        didSet {
            layer.cornerRadius = self.CornerRadius
            layer.masksToBounds = true
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBInspectable var BorderWidth : CGFloat = 0 {
        didSet {
            layer.borderWidth = self.BorderWidth
        }
    }
    
    @IBInspectable var BorderColor : UIColor? {
           didSet {
            layer.borderColor = self.BorderColor?.cgColor
           }
       }
    
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

@IBDesignable
class RoundedCornerView: UIView {

    var cornerRadiusValue : CGFloat = 0
    var corners : UIRectCorner = []
    var frameSizeValue = CGRect(x: 0, y: 0, width: 0, height: 0)

    @IBInspectable public var cornerRadius : CGFloat {
        get {
            return cornerRadiusValue
        }
        set {
            cornerRadiusValue = newValue
        }
    }
    @IBInspectable public var frameSize : CGRect {
        get {
            return frameSizeValue
        }
        set {
            frameSizeValue = newValue
        }
    }

    @IBInspectable public var topLeft : Bool {
        get {
            return corners.contains(.topLeft)
        }
        set {
            setCorner(newValue: newValue, for: .topLeft)
        }
    }

    @IBInspectable public var topRight : Bool {
        get {
            return corners.contains(.topRight)
        }
        set {
            setCorner(newValue: newValue, for: .topRight)
        }
    }

    @IBInspectable public var bottomLeft : Bool {
        get {
            return corners.contains(.bottomLeft)
        }
        set {
            setCorner(newValue: newValue, for: .bottomLeft)
        }
    }

    @IBInspectable public var bottomRight : Bool {
        get {
            return corners.contains(.bottomRight)
        }
        set {
            setCorner(newValue: newValue, for: .bottomRight)
        }
    }

    func setCorner(newValue: Bool, for corner: UIRectCorner) {
        if newValue {
            addRectCorner(corner: corner)
        } else {
            removeRectCorner(corner: corner)
        }
    }

    func addRectCorner(corner: UIRectCorner) {
        corners.insert(corner)
        updateCorners()
    }

    func removeRectCorner(corner: UIRectCorner) {
        if corners.contains(corner) {
            corners.remove(corner)
            updateCorners()
        }
    }

    func updateCorners() {
        
        let path = UIBezierPath(roundedRect: frameSize, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadiusValue, height: cornerRadiusValue))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
@IBDesignable class DesignableImageView: UIImageView {
    @IBInspectable var CornerRadius :CGFloat = 0 {
           didSet {
               layer.cornerRadius = self.CornerRadius
               layer.masksToBounds = true
               self.translatesAutoresizingMaskIntoConstraints = false
           }
       }
    @IBInspectable var BorderWidth : CGFloat = 0 {
        didSet {
            layer.borderWidth = self.BorderWidth
        }
    }
    
    @IBInspectable var BorderColor : UIColor? {
           didSet {
            layer.borderColor = self.BorderColor?.cgColor
           }
       }
    @IBInspectable var ShadowRadius: CGFloat = 0 {
    didSet {
        layer.shadowRadius = self.ShadowRadius
    }
    }
    @IBInspectable var ShadowOpacity: Float = 0 {
         didSet {
            layer.shadowOpacity = self.ShadowOpacity
         }
      }
}

@IBDesignable class DesignableTextView: UITextView {
    
    @IBInspectable var CornerRadius :CGFloat = 0 {
        didSet {
            layer.cornerRadius = self.CornerRadius
            layer.masksToBounds = true
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBInspectable var BorderWidth : CGFloat = 0 {
        didSet {
            layer.borderWidth = self.BorderWidth
        }
    }
    
    @IBInspectable var BorderColor : UIColor? {
           didSet {
            layer.borderColor = self.BorderColor?.cgColor
           }
       }
    
//    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//    override func caretRect(for position: UITextPosition) -> CGRect {
//         return bounds.inset(by: padding)
//    }
}
@IBDesignable class BadgeButton: UIButton {

    @IBInspectable  var badgeLabel = UILabel()

    @IBInspectable var badge: String? {
        didSet {
            addbadgetobutton(badge: badge)
        }
    }

    @IBInspectable var badgeBackgroundColor = UIColor.red {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }

    @IBInspectable var badgeTextColor = UIColor.white {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }

    @IBInspectable var badgeFont = UIFont.systemFont(ofSize: 12.0) {
        didSet {
            badgeLabel.font = badgeFont
        }
    }

    public var badgeEdgeInsets: UIEdgeInsets? {
        didSet {
            addbadgetobutton(badge: badge)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addbadgetobutton(badge: nil)
    }

    func addbadgetobutton(badge: String?) {
        badgeLabel.text = badge
        badgeLabel.textColor = badgeTextColor
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.font = badgeFont
        badgeLabel.sizeToFit()
        badgeLabel.textAlignment = .center
        let badgeSize = badgeLabel.frame.size

        let height = max(18, Double(badgeSize.height) + 5.0)
        let width = max(height, Double(badgeSize.width) + 10.0)

        var vertical: Double?, horizontal: Double?
        if let badgeInset = self.badgeEdgeInsets {
            vertical = Double(badgeInset.top) - Double(badgeInset.bottom)
            horizontal = Double(badgeInset.left) - Double(badgeInset.right)

            let x = (Double(bounds.size.width) - 10 + horizontal!)
            let y = -(Double(badgeSize.height) / 2) - 10 + vertical!
            badgeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        } else {
            let x = self.frame.width - CGFloat((width / 2.0))
            let y = CGFloat(-(height / 2.0))
            badgeLabel.frame = CGRect(x: x, y: y, width: CGFloat(width), height: CGFloat(height))
        }

        badgeLabel.layer.cornerRadius = badgeLabel.frame.height/2
        badgeLabel.layer.masksToBounds = true
        addSubview(badgeLabel)
        badgeLabel.isHidden = badge != nil ? false : true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addbadgetobutton(badge: nil)
       // fatalError("init(coder:) is not implemented")
    }
}
