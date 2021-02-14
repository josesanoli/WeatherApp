//
//  DataConversion.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import Foundation

extension Double {
    
    func kelvinToCelsius() -> String{
        let celsiusTemp = self - 273.15
        return String(format: "%.0f", celsiusTemp)
    }
}
