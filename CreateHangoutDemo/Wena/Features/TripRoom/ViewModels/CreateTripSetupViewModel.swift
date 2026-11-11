//
//  CreateTripSetupViewModel.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class CreateTripSetupViewModel {
    enum Destination: CaseIterable, Identifiable {
        case maggiore
        case hamptonSquare
        case blokM

        var id: Self { self }

        var name: LocalizedStringResource {
            switch self {
            case .maggiore: "tripSetup.destination.maggiore"
            case .hamptonSquare: "tripSetup.destination.hamptonSquare"
            case .blokM: "tripSetup.destination.blokM"
            }
        }

        // TODO: Load available destinations from the destination dataset.
        var backendID: String? {
            switch self {
            case .maggiore: "maggiore"
            case .hamptonSquare, .blokM: nil
            }
        }

        var isAvailable: Bool { backendID != nil }
    }

    private let tripService: TripCreationService
    let calendar: Calendar
    private(set) var selectedDestination: Destination = .maggiore
    var displayName = ""
    var budget = "100000"
    var date: Date
    var foodSetting: TripFoodSetting = .halal
    private(set) var createdTrip: CreatedTrip?
    private(set) var isCreating = false
    var creationError: LocalizedStringResource?

    init(tripService: TripCreationService, now: Date = .now) {
        self.tripService = tripService
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Jakarta") ?? .gmt
        self.calendar = calendar
        date = calendar.startOfDay(for: now)
    }

    func selectDestination(_ destination: Destination) {
        guard destination.isAvailable, !isCreating, createdTrip == nil else { return }
        selectedDestination = destination
    }

    func sanitizeBudget() {
        let digits = budget.filter { $0.isASCII && $0.isNumber }
        if budget != digits { budget = digits }
    }

    func createTrip() async -> Bool {
        if createdTrip != nil { return true }
        guard !isCreating, let destinationID = selectedDestination.backendID else { return false }

        let name = displayName.split(whereSeparator: \.isWhitespace).joined(separator: " ")
        guard (1...20).contains(name.unicodeScalars.count) else {
            creationError = "tripSetup.error.name"
            return false
        }
        guard let amount = Int32(budget), amount > 0 else {
            creationError = "tripSetup.error.budget"
            return false
        }

        let request = CreateTripRequest(
            destinationID: destinationID,
            budgetPerPersonIDR: amount,
            date: calendar.startOfDay(for: date),
            halalFilter: foodSetting == .halal ? .certifiedOrClaimed : .none,
            displayName: name
        )
        creationError = nil
        isCreating = true
        defer { isCreating = false }

        do {
            createdTrip = try await tripService.createTrip(request)
            displayName = name
            return !Task.isCancelled
        } catch {
            guard !Task.isCancelled, !(error is CancellationError) else { return false }
            switch error as? TripCreationValidationError {
            case .invalidDisplayName: creationError = "tripSetup.error.name"
            case .invalidBudget: creationError = "tripSetup.error.budget"
            case .invalidDate: creationError = "tripSetup.error.date"
            case nil: creationError = "tripSetup.error.request"
            }
            return false
        }
    }
}
