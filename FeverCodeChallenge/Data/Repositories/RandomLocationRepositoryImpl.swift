//
//  RandomLocationRepositoryImpl.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import Foundation

final class RandomLocationRepositoryImpl: RandomLocationRepository {
    
    func getRandomLocation(completion: @escaping (LocationCoordinates) -> Void) {
        
        let randomLatitude = Double.random(min: -90, max: 90)
        let randomLongitude = Double.random(min: -180, max: 180)

        let coordinates = LocationCoordinates(latitude: randomLatitude, longitude: randomLongitude)
        
        completion(coordinates)

    }
    
}
