//
//  TripFoodSetting.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import Foundation

enum TripFoodSetting: CaseIterable, Identifiable {
    case halal
    case nonHalal

    var id: Self { self }

    var title: LocalizedStringResource {
        switch self {
        case .halal: "tripSetup.food.halal"
        case .nonHalal: "tripSetup.food.nonHalal"
        }
    }
}
