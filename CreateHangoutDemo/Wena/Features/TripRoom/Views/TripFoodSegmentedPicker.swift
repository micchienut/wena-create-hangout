//
//  TripFoodSegmentedPicker.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import SwiftUI
import UIKit
import WenaDesignSystem

struct TripFoodSegmentedPicker: UIViewRepresentable {
    @Binding var selection: TripFoodSetting
    let height: CGFloat
    let textSize: CGFloat

    func makeUIView(context: Context) -> UISegmentedControl {
        let control = UISegmentedControl()
        for (index, setting) in TripFoodSetting.allCases.enumerated() {
            control.insertSegment(withTitle: String(localized: setting.title), at: index, animated: false)
        }
        control.addTarget(context.coordinator, action: #selector(Coordinator.selectionChanged(_:)), for: .valueChanged)
        control.accessibilityIdentifier = "tripSetup.foodPicker"
        control.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return control
    }

    func updateUIView(_ control: UISegmentedControl, context: Context) {
        context.coordinator.selection = $selection
        control.backgroundColor = UIColor(WenaColor.bgMuted)
        control.selectedSegmentTintColor = UIColor(WenaColor.bgBrand)
        control.selectedSegmentIndex = TripFoodSetting.allCases.firstIndex(of: selection) ?? 0
        let font = UIFont.systemFont(ofSize: textSize, weight: .medium)
        control.setTitleTextAttributes([
            .font: font,
            .foregroundColor: UIColor(WenaColor.textSecondary)
        ], for: .normal)
        control.setTitleTextAttributes([
            .font: font,
            .foregroundColor: UIColor(WenaColor.textOnBrand)
        ], for: .selected)
        for (index, setting) in TripFoodSetting.allCases.enumerated() {
            control.setTitle(String(localized: setting.title), forSegmentAt: index)
        }
    }

    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UISegmentedControl, context: Context) -> CGSize? {
        CGSize(width: proposal.width ?? uiView.intrinsicContentSize.width, height: height)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(selection: $selection)
    }

    @MainActor
    final class Coordinator: NSObject {
        var selection: Binding<TripFoodSetting>

        init(selection: Binding<TripFoodSetting>) {
            self.selection = selection
        }

        @objc func selectionChanged(_ control: UISegmentedControl) {
            guard TripFoodSetting.allCases.indices.contains(control.selectedSegmentIndex) else { return }
            selection.wrappedValue = TripFoodSetting.allCases[control.selectedSegmentIndex]
        }
    }
}
