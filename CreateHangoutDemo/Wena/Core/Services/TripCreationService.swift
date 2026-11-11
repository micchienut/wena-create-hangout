//
//  TripCreationService.swift
//  CreateHangoutDemo
//
//  Created by Michelle Nathania on 11/11/26.
//

protocol TripCreationService {
    func createTrip(_ request: CreateTripRequest) async throws -> CreatedTrip
}
