//
//  JsonData.swift
//  WeatherAppTests
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import Foundation

public let jsonTest: String = "{\"coord\":{\"lon\":-30,\"lat\":20},\"weather\":[{\"id\":802,\"main\":\"Clouds\",\"description\":\"scattered clouds\",\"icon\":\"03n\"}],\"base\":\"stations\",\"main\":{\"temp\":247,\"feels_like\":242.19,\"temp_min\":247,\"temp_max\":247,\"pressure\":1027,\"humidity\":91,\"sea_level\":1027,\"grnd_level\":993},\"visibility\":10000,\"wind\":{\"speed\":1.46,\"deg\":189},\"clouds\":{\"all\":27},\"dt\":1613233816,\"sys\":{\"sunrise\":0,\"sunset\":0},\"timezone\":10800,\"id\":0,\"name\":\"Test City\",\"cod\":200}"

public let jsonErrorTest: String = "{\"message\":\"Message to test\",\"cod\":401}"

public let jsonBadFormedTest: String = "{\"cod\":}"

public func jsonToData(json: String) -> Data? {
    let data = json.data(using: .utf8)!
    return data
}
