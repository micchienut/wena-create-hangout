//
//  TripCreation.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import Foundation

nonisolated struct CreateTripRequest: Sendable {
    enum HalalFilter: String, Sendable {
        case certified = "halal_certified"
        case certifiedOrClaimed = "halal_or_claimed"
        case none
    }

    let destinationID: String
    let budgetPerPersonIDR: Int32
    let date: Date
    let halalFilter: HalalFilter
    let displayName: String
}

nonisolated struct CreatedTrip: Decodable, Sendable {
    let id: UUID
    let inviteCode: String

    private enum CodingKeys: String, CodingKey {
        case id = "trip_id"
        case inviteCode = "code"
    }
}

nonisolated enum TripCreationValidationError: Error, Equatable, Sendable {
    case invalidDisplayName
    case invalidBudget
    case invalidDate
}
