//
//  CreateTripSetupView.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import SwiftUI
import WenaDesignSystem

@MainActor
struct CreateTripSetupView: View {
    @State private var showsShareTaste = false
    @State private var createRequested = false
    @State private var viewModel: CreateTripSetupViewModel
    @FocusState private var displayNameIsFocused: Bool
    @FocusState private var budgetIsFocused: Bool
    @State private var budgetBounds = CGRect.zero
    @Environment(\.accessibilityDifferentiateWithoutColor) private var differentiateWithoutColor

    init(tripService: TripCreationService) {
        _viewModel = State(initialValue: CreateTripSetupViewModel(tripService: tripService))
    }

    var body: some View {
        @Bindable var viewModel = viewModel
        ScrollView {
            VStack(alignment: .leading, spacing: WenaSpacing.space24) {
                VStack(alignment: .leading, spacing: WenaSpacing.space8) {
                    Text("tripSetup.title")
                        .wenaTypography(.largeTitle, emphasized: true)
                        .foregroundStyle(WenaColor.textPrimary)
                        .accessibilityAddTraits(.isHeader)
                    Text("tripSetup.subtitle")
                        .wenaTypography(.callout)
                        .foregroundStyle(WenaColor.textSecondary)
                }
                .fixedSize(horizontal: false, vertical: true)

                VStack(alignment: .leading, spacing: WenaSpacing.space8) {
                    fieldLabel("tripSetup.displayName")
                    TextField("tripSetup.displayName", text: $viewModel.displayName)
                        .focused($displayNameIsFocused)
                        .textContentType(.nickname)
                        .textInputAutocapitalization(.words)
                        .wenaTypography(.body, emphasized: true)
                        .foregroundStyle(WenaColor.textPrimary)
                        .padding(WenaSpacing.space16)
                        .background(WenaColor.bgMuted, in: RoundedRectangle(cornerRadius: WenaRadius.radius24))
                        .accessibilityIdentifier("tripSetup.displayName")
                }

                destinations

                VStack(alignment: .leading, spacing: WenaSpacing.space8) {
                    fieldLabel("tripSetup.budget")
                    HStack(spacing: WenaSpacing.space8) {
                        Text("tripSetup.currency")
                            .foregroundStyle(WenaColor.textSecondary)
                            .accessibilityHidden(true)
                        TextField("tripSetup.budget", text: $viewModel.budget)
                            .keyboardType(.numberPad)
                            .focused($budgetIsFocused)
                            .accessibilityIdentifier("tripSetup.budget")
                            .onChange(of: viewModel.budget) { viewModel.sanitizeBudget() }
                    }
                    .wenaTypography(.body, emphasized: true)
                    .foregroundStyle(WenaColor.textPrimary)
                    .padding(WenaSpacing.space16)
                    .background(WenaColor.bgMuted, in: RoundedRectangle(cornerRadius: WenaRadius.radius24))
                    .onGeometryChange(for: CGRect.self) { proxy in
                        proxy.frame(in: .global)
                    } action: { budgetBounds = $0 }
                }

                VStack(alignment: .leading, spacing: WenaSpacing.space8) {
                    fieldLabel("tripSetup.date")
                    DatePicker("tripSetup.date", selection: $viewModel.date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .environment(\.calendar, viewModel.calendar)
                        .environment(\.timeZone, viewModel.calendar.timeZone)
                        .labelsHidden()
                        .tint(WenaColor.textPrimary)
                        .padding(WenaSpacing.space16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(WenaColor.bgMuted, in: RoundedRectangle(cornerRadius: WenaRadius.radius24))
                        .accessibilityIdentifier("tripSetup.date")
                }

                VStack(alignment: .leading, spacing: WenaSpacing.space8) {
                    fieldLabel("tripSetup.food")
                    TripFoodSettingControl(selection: $viewModel.foodSetting)
                    Text("tripSetup.food.detail")
                        .wenaTypography(.caption1)
                        .foregroundStyle(WenaColor.textSecondary)
                }
            }
            .padding(WenaSpacing.space24)
            .frame(maxWidth: .infinity, alignment: .leading)
            .disabled(viewModel.isCreating || viewModel.createdTrip != nil)
        }
        .scrollBounceBehavior(.basedOnSize)
        .scrollDismissesKeyboard(.interactively)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Button {
                budgetIsFocused = false
                displayNameIsFocused = false
                createRequested = true
            } label: {
                if viewModel.isCreating {
                    Text("tripSetup.creating")
                } else if viewModel.createdTrip != nil {
                    Text("onboarding.foodPicks.continue")
                } else {
                    Text("tripSetup.create")
                }
            }
            .buttonStyle(WenaActionButtonStyle())
            .disabled(viewModel.isCreating || createRequested)
            .accessibilityIdentifier("tripSetup.create")
            .padding(.horizontal, WenaSpacing.space24)
            .padding(.top, WenaSpacing.space8)
            .background(WenaColor.bgBase)
        }
        .background(WenaColor.bgBase.ignoresSafeArea())
        .navigationDestination(isPresented: $showsShareTaste) {
            if let trip = viewModel.createdTrip {
                ContentUnavailableView(
                    "demo.hangoutCreated.title",
                    systemImage: "checkmark.circle",
                    description: Text("demo.hangoutCreated.code \(trip.inviteCode)")
                )
            }
        }
        .task(id: createRequested) {
            guard createRequested else { return }
            defer { createRequested = false }
            if await viewModel.createTrip() {
                showsShareTaste = true
            }
        }
        .alert(
            "tripSetup.error.title",
            isPresented: Binding(
                get: { viewModel.creationError != nil },
                set: { if !$0 { viewModel.creationError = nil } }
            ),
            presenting: viewModel.creationError
        ) { _ in
            Button("onboarding.error.close", role: .cancel) {}
        } message: { error in
            Text(error)
        }
        .navigationBarTitleDisplayMode(.inline)
        .simultaneousGesture(SpatialTapGesture(coordinateSpace: .global).onEnded { event in
            if !budgetBounds.contains(event.location) { budgetIsFocused = false }
        })
    }

    private var destinations: some View {
        VStack(alignment: .leading, spacing: WenaSpacing.space8) {
            fieldLabel("tripSetup.destination")
            TripDestinationLayout {
                ForEach(CreateTripSetupViewModel.Destination.allCases) { destination in
                    destinationPill(destination)
                }
            }
            .accessibilityElement(children: .contain)
            Text("tripSetup.destination.detail")
                .wenaTypography(.caption1)
                .foregroundStyle(WenaColor.textSecondary)
        }
    }

    private func destinationPill(_ destination: CreateTripSetupViewModel.Destination) -> some View {
        let isSelected = viewModel.selectedDestination == destination
        let textColor = destination.isAvailable ? WenaColor.textPrimary : WenaColor.textDisabled

        return Button {
            viewModel.selectDestination(destination)
        } label: {
            HStack(spacing: WenaSpacing.space8) {
                Text(destination.name)
                if isSelected && differentiateWithoutColor {
                    Image(systemName: "checkmark")
                        .accessibilityHidden(true)
                }
            }
                .wenaTypography(.subheadline, emphasized: true)
            .foregroundStyle(isSelected ? WenaColor.textOnAccentOrange : textColor)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, WenaSpacing.space16)
                .padding(.vertical, WenaSpacing.space12)
                .frame(minHeight: WenaSpacing.space48)
            .background(isSelected ? WenaColor.bgBrand : WenaColor.bgMuted, in: Capsule())
        }
        .buttonStyle(.plain)
        .disabled(!destination.isAvailable)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private func fieldLabel(_ title: LocalizedStringKey) -> some View {
        Text(title)
            .wenaTypography(.footnote, emphasized: true)
            .foregroundStyle(WenaColor.textSecondary)
    }
}

#Preview("Setup") {
    NavigationStack { CreateTripSetupView(tripService: PreviewTripCreationService()) }
}

#Preview("Largest text") {
    NavigationStack { CreateTripSetupView(tripService: PreviewTripCreationService()) }
        .dynamicTypeSize(.accessibility5)
}

struct PreviewTripCreationService: TripCreationService {
    func createTrip(_ request: CreateTripRequest) async throws -> CreatedTrip {
        CreatedTrip(id: UUID(), inviteCode: "123456")
    }
}
