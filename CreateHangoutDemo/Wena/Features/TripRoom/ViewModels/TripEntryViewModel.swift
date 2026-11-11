//
//  TripEntryViewModel.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import Observation

@Observable
@MainActor
final class TripEntryViewModel {
    private(set) var selectedMode: TripEntryMode

    init(selectedMode: TripEntryMode = .create) {
        self.selectedMode = selectedMode
    }

    func select(_ mode: TripEntryMode) {
        selectedMode = mode
    }
}
