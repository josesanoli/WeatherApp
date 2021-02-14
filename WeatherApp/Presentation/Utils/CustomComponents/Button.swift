//
//  UIButtonExtension.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import UIKit

class Button: UIButton {

    @IBInspectable public var referenceText: String = "" {
      didSet {
          self.setTitle(NSLocalizedString(referenceText, comment: ""), for: .normal)
      }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

}


