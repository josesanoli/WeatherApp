//
//  UIButtonExtension.swift
//  FeverCodeChallenge
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
}


