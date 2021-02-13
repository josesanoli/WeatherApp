//
//  StringExtensions.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
