//
//  GetLocationUseCase.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import Foundation

protocol GetLocationUseCase {
    func getRandomLocation(completion: @escaping (LocationCoordinates) -> Void)
}

final class GetLocationUseCaseImpl: GetLocationUseCase {
    
    private let randomLocationRepository: RandomLocationRepository
    
    init(randomLocationRepository: RandomLocationRepository) {
        self.randomLocationRepository = randomLocationRepository
    }
    
    func getRandomLocation(completion: @escaping (LocationCoordinates) -> Void) {
        return randomLocationRepository.getRandomLocation(completion: { result in
            completion(result)
        })
    }
    
}
