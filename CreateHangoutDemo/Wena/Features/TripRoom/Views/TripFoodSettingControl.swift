//
//  TripFoodSettingControl.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import SwiftUI
import UIKit
import WenaDesignSystem

struct TripFoodSettingControl: View {
    @Binding var selection: TripFoodSetting
    @ScaledMetric(relativeTo: .body) private var controlHeight = WenaSpacing.space48
    @ScaledMetric(relativeTo: .body) private var textSize = UIFont.preferredFont(
        forTextStyle: .body,
        compatibleWith: UITraitCollection(preferredContentSizeCategory: .large)
    ).pointSize

    var body: some View {
        ViewThatFits(in: .horizontal) {
            TripFoodSegmentedPicker(selection: $selection, height: controlHeight, textSize: textSize)
                .frame(minWidth: minimumWidth)
            Picker("tripSetup.food", selection: $selection) {
                ForEach(TripFoodSetting.allCases) { setting in
                    Text(setting.title).tag(setting)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
            .wenaTypography(.body, emphasized: true)
            .tint(WenaColor.textOnBrand)
            .padding(WenaSpacing.space16)
            .frame(maxWidth: .infinity, minHeight: WenaSpacing.space48)
            .background(WenaColor.bgBrand, in: RoundedRectangle(cornerRadius: WenaRadius.radius24))
            .accessibilityIdentifier("tripSetup.foodMenu")
        }
    }

    private var minimumWidth: CGFloat {
        let font = UIFont.systemFont(ofSize: textSize, weight: .medium)
        let widestTitle = TripFoodSetting.allCases.map {
            (String(localized: $0.title) as NSString).size(withAttributes: [.font: font]).width
        }.max() ?? 0
        return (widestTitle + WenaSpacing.space32) * CGFloat(TripFoodSetting.allCases.count)
    }
}
