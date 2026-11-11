//
//  TripEntryOptionButton.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import SwiftUI
import WenaDesignSystem

struct TripEntryOptionButton: View {
    let mode: TripEntryMode
    let isSelected: Bool
    let onSelect: () -> Void

    @Environment(\.accessibilityDifferentiateWithoutColor) private var differentiateWithoutColor
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    private let contentInset: CGFloat = 20
    private var artworkSize: CGSize {
        mode == .create ? CGSize(width: 115, height: 104) : CGSize(width: 89, height: 96)
    }

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: WenaRadius.radius24)

        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: WenaSpacing.space8) {
                Text(mode.role)
                    .wenaTypography(.footnote, emphasized: true)
                    .padding(.horizontal, WenaSpacing.space12)
                    .padding(.vertical, WenaSpacing.space4)
                    .background(isSelected ? WenaColor.bgBrandSubtle : WenaColor.bgBrand, in: Capsule())

                HStack(spacing: WenaSpacing.space8) {
                    Text(mode.title)
                        .wenaTypography(.title2, emphasized: true)
                    if isSelected && differentiateWithoutColor {
                        Image(systemName: "checkmark.circle.fill")
                            .accessibilityHidden(true)
                    }
                }

                Text(mode.detail)
                    .wenaTypography(.subheadline)
            }
            .foregroundStyle(WenaColor.textPrimary)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, contentInset)
            .padding(.leading, contentInset)
            .padding(.trailing, dynamicTypeSize.isAccessibilitySize ? contentInset : artworkSize.width)
            .padding(.bottom, dynamicTypeSize.isAccessibilitySize ? artworkSize.height : contentInset)
            .frame(maxWidth: .infinity, minHeight: 154, alignment: .topLeading)
            .background(isSelected ? WenaColor.bgBrand : WenaColor.bgBrandSubtle)
            .overlay(alignment: .bottomTrailing) {
                Image(decorative: mode == .create ? "CreateHangout" : "JoinHangout")
                    .resizable()
                    .scaledToFit()
                    .frame(width: artworkSize.width, height: artworkSize.height)
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
            }
            .clipShape(shape)
            .contentShape(shape)
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
        .accessibilityInputLabels([Text(mode.title)])
        .accessibilityIdentifier(mode == .create ? "tripEntry.createOption" : "tripEntry.joinOption")
    }
}
