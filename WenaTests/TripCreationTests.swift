//
//  TripCreationTests.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import Foundation
import Testing
@testable import Wena

@MainActor
private final class RecordingTripService: TripCreationService {
    let trip = CreatedTrip(id: UUID(), inviteCode: "012345")
    var requests: [CreateTripRequest] = []
    var error: (any Error)?

    func createTrip(_ request: CreateTripRequest) async throws -> CreatedTrip {
        requests.append(request)
        if let error { throw error }
        return trip
    }
}

@MainActor
@Suite struct TripCreationTests {
    @Test func sendsAgreedInputsAndReusesCreatedTrip() async throws {
        let service = RecordingTripService()
        let formatter = ISO8601DateFormatter()
        let now = try #require(formatter.date(from: "2026-11-10T16:55:00Z"))
        let model = CreateTripSetupViewModel(tripService: service, now: now)
        #expect(model.date == formatter.date(from: "2026-11-09T17:00:00Z"))

        model.date = try #require(formatter.date(from: "2026-11-11T06:45:00Z"))
        model.displayName = "  Rafi   Putra  "
        model.selectDestination(.hamptonSquare)

        #expect(await model.createTrip())
        #expect(await model.createTrip())
        let request = try #require(service.requests.first)
        #expect(service.requests.count == 1)
        #expect(request.displayName == "Rafi Putra")
        #expect(request.destinationID == "maggiore")
        #expect(request.budgetPerPersonIDR == 100_000)
        #expect(request.date == formatter.date(from: "2026-11-10T17:00:00Z"))
        #expect(request.halalFilter == .certifiedOrClaimed)
        #expect(model.createdTrip?.id == service.trip.id)
        #expect(model.createdTrip?.inviteCode == "012345")
    }

    @Test func rejectsInvalidDraftBeforeCallingService() async {
        let service = RecordingTripService()
        let model = CreateTripSetupViewModel(tripService: service)
        model.displayName = "  "
        #expect(await model.createTrip() == false)

        model.displayName = "Rafi"
        model.budget = "2147483648"
        #expect(await model.createTrip() == false)
        #expect(service.requests.isEmpty)
        #expect(model.createdTrip == nil)
        #expect(model.creationError != nil)
    }

    @Test func failedRequestDoesNotCreateNavigationState() async throws {
        let service = RecordingTripService()
        service.error = TripCreationValidationError.invalidDate
        let model = CreateTripSetupViewModel(tripService: service)
        model.displayName = "Rafi"
        model.foodSetting = .nonHalal

        #expect(await model.createTrip() == false)
        #expect(model.createdTrip == nil)
        #expect(model.creationError?.key == "tripSetup.error.date")
        #expect(!model.isCreating)
        let request = try #require(service.requests.first)
        #expect(request.halalFilter == CreateTripRequest.HalalFilter.none)
    }

    @Test func decodesServerTripAndPreservesLeadingZeroInInviteCode() throws {
        let id = UUID()
        let data = Data("""
            {"trip_id":"\(id.uuidString)","code":"012345","status":"open"}
            """.utf8)
        let trip = try JSONDecoder().decode(CreatedTrip.self, from: data)
        #expect(trip.id == id)
        #expect(trip.inviteCode == "012345")
    }
}
