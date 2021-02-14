//
//  StringExtensions.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import Foundation

extension String {
    /// Returns the same string with the first character capitalivez
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

/// Localized string
///
/// - Parameter key: Localizable file string key
/// - Returns:       Localizable  string value for language
func localizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}


