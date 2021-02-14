//
//  NumericDataExtension.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import Foundation

public extension Double {

    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }

    /// Random double between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random double point number between 0 and n max
    static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
    
    func toString() -> String {
        return String(format: "%.4f",self)
    }
    
    func toString2Dec() -> String {
        return String(format: "%.2f",self)
    }
}

public extension Int {
    func toString() -> String {
        return String(self)
    }
}
