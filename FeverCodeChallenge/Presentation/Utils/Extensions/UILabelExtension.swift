//
//  UILabelExtension.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import UIKit

extension UILabel {
    @IBInspectable var localizableText: String? {
        get { return text }
        set(value) { text = NSLocalizedString(value!, comment: "") }
    }
}
