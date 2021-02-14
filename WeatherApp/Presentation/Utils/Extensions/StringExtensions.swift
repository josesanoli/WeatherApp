//
//  StringExtensions.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

func localizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}


