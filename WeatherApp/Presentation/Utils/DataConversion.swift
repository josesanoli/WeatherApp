//
//  DataConversion.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import Foundation

extension Double {
    
    /// Returns the conversion from Kelvin to celsius temperature in String format
    func kelvinToCelsius() -> String{
        let celsiusTemp = self - 273.15
        return String(format: "%.0f", celsiusTemp)
    }
}
