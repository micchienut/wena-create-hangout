//
//  WenaTypography.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import SwiftUI
import UIKit

/// Applies the source's tracking and leading without fixing the text container's height.
struct WenaTypography: ViewModifier {
    let style: WenaFont.Style
    let emphasized: Bool
    @Environment(\.legibilityWeight) private var legibilityWeight
    @ScaledMetric private var tracking: CGFloat
    @ScaledMetric private var extraLeading: CGFloat

    init(style: WenaFont.Style, emphasized: Bool = false) {
        WenaFontRegistration.ensureRegistered()
        self.style = style
        self.emphasized = emphasized
        _tracking = ScaledMetric(wrappedValue: style.tracking, relativeTo: style.textStyle)
        // Never compress the real font's line box: that can clip custom-font glyphs at Larger Text.
        let regularHeight = UIFont(name: style.fontName(), size: style.pointSize)?.lineHeight ?? style.lineHeight
        let emphasizedHeight = UIFont(name: style.fontName(emphasized: true), size: style.pointSize)?.lineHeight
            ?? style.lineHeight
        let leading = max(0, style.lineHeight - max(regularHeight, emphasizedHeight))
        _extraLeading = ScaledMetric(wrappedValue: leading, relativeTo: style.textStyle)
    }

    func body(content: Content) -> some View {
        content
            .font(WenaFont.font(style, emphasized: emphasized || legibilityWeight == .bold))
            .tracking(tracking)
            .lineSpacing(extraLeading)
            .padding(.vertical, extraLeading / 2)
    }
}

public extension View {
    func wenaTypography(_ style: WenaFont.Style, emphasized: Bool = false) -> some View {
        modifier(WenaTypography(style: style, emphasized: emphasized))
    }
}
