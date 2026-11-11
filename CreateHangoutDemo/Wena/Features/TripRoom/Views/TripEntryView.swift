//
//  TripEntryView.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import SwiftUI
import WenaDesignSystem

@MainActor
struct TripEntryView: View {
    @State private var viewModel: TripEntryViewModel
    @State private var showsCreateSetup = false
    private let tripService: TripCreationService

    init(viewModel: TripEntryViewModel? = nil, tripService: TripCreationService) {
        _viewModel = State(initialValue: viewModel ?? TripEntryViewModel())
        self.tripService = tripService
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: WenaSpacing.space24) {
                VStack(alignment: .leading, spacing: WenaSpacing.space8) {
                    Text(.tripEntryTitle)
                        .wenaTypography(.largeTitle, emphasized: true)
                        .foregroundStyle(WenaColor.textPrimary)
                        .accessibilityAddTraits(.isHeader)
                    Text(.tripEntrySubtitle)
                        .wenaTypography(.callout)
                        .foregroundStyle(WenaColor.textSecondary)
                }
                .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: WenaSpacing.space24) {
                    ForEach(TripEntryMode.allCases) { mode in
                        TripEntryOptionButton(mode: mode, isSelected: viewModel.selectedMode == mode) {
                            viewModel.select(mode)
                        }
                    }
                }
                .accessibilityElement(children: .contain)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, WenaSpacing.space24)
            .padding(.top, WenaSpacing.space4)
            .padding(.bottom, WenaSpacing.space24)
        }
        .scrollBounceBehavior(.basedOnSize)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Button {
                showsCreateSetup = true
            } label: {
                Text(viewModel.selectedMode.title)
            }
            .buttonStyle(WenaActionButtonStyle())
            .disabled(viewModel.selectedMode == .join)
            .accessibilityIdentifier("tripEntry.continue")
            .padding(.horizontal, WenaSpacing.space24)
            .padding(.top, WenaSpacing.space8)
            .background(WenaColor.bgBase)
        }
        .background(WenaColor.bgBase.ignoresSafeArea())
        .navigationDestination(isPresented: $showsCreateSetup) {
            CreateTripSetupView(tripService: tripService)
        }
    }
}

#Preview("Create selected") {
    NavigationStack { TripEntryView(tripService: PreviewTripCreationService()) }
}

#Preview("Join selected") {
    NavigationStack {
        TripEntryView(
            viewModel: TripEntryViewModel(selectedMode: .join),
            tripService: PreviewTripCreationService()
        )
    }
}

#Preview("Largest text") {
    NavigationStack { TripEntryView(tripService: PreviewTripCreationService()) }
        .dynamicTypeSize(.accessibility5)
}

#Preview("Dark appearance — palette pending") {
    NavigationStack { TripEntryView(tripService: PreviewTripCreationService()) }
        .preferredColorScheme(.dark)
}
