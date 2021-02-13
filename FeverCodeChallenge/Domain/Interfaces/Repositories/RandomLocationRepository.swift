//
//  RandomLocationRepository.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

protocol RandomLocationRepository {
    func getRandomLocation(completion: @escaping (LocationCoordinates) -> Void)
}
