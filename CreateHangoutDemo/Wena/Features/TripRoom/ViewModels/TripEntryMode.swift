//
//  TripEntryMode.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import Foundation

enum TripEntryMode: CaseIterable, Identifiable {
    case create
    case join

    var id: Self { self }

    var title: LocalizedStringResource {
        switch self {
        case .create: .tripEntryCreateTitle
        case .join: .tripEntryJoinTitle
        }
    }

    var role: LocalizedStringResource {
        switch self {
        case .create: .tripEntryCreateRole
        case .join: .tripEntryJoinRole
        }
    }

    var detail: LocalizedStringResource {
        switch self {
        case .create: .tripEntryCreateDetail
        case .join: .tripEntryJoinDetail
        }
    }
}
