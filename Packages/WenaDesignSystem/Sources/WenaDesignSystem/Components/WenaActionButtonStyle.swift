//
//  WenaActionButtonStyle.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import SwiftUI

public struct WenaActionButtonStyle: ButtonStyle {
    public enum Variant {
        case primary
        case secondary
        case cream
    }

    @Environment(\.isEnabled) private var isEnabled
    private let variant: Variant
    private let minHeight: CGFloat

    public init(_ variant: Variant = .primary, minHeight: CGFloat = 52) {
        self.variant = variant
        self.minHeight = max(44, minHeight)
    }

    public func makeBody(configuration: Configuration) -> some View {
        let edgeDepth = WenaElevation.stickerOffset
        configuration.label
            .wenaTypography(.body, emphasized: true)
            .foregroundStyle(WenaColor.textOnBrand)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, WenaSpacing.space16)
            .padding(.vertical, minHeight < 52 ? WenaSpacing.space8 : WenaSpacing.space12)
            .frame(maxWidth: .infinity, minHeight: minHeight - edgeDepth)
            .background(backgroundColor, in: Capsule())
            .offset(y: isEnabled && configuration.isPressed ? edgeDepth : 0)
            .padding(.bottom, edgeDepth)
            .background {
                Capsule().fill(edgeColor).padding(.top, edgeDepth)
            }
            .contentShape(Rectangle())
    }

    private var backgroundColor: Color {
        switch variant {
        case .primary: isEnabled ? WenaColor.bgBrand : WenaColor.orangeTint
        case .secondary: WenaColor.bgBrandSubtle
        case .cream: WenaColor.bgBase
        }
    }

    private var edgeColor: Color {
        switch variant {
        case .primary: isEnabled ? WenaColor.accentDarkOrange : WenaColor.borderDefault
        case .secondary: WenaColor.borderDefault
        case .cream: WenaColor.bgBrandSubtle
        }
    }
}

#if DEBUG
private struct WenaActionButtonStylePreview: View {
    var body: some View {
        ScrollView {
            VStack(spacing: WenaSpacing.space24) {
                Button {} label: {
                    Text(verbatim: "Primary")
                }
                .buttonStyle(WenaActionButtonStyle(.primary))

                Button {} label: {
                    Text(verbatim: "Secondary")
                }
                .buttonStyle(WenaActionButtonStyle(.secondary))
            }
            .padding(WenaSpacing.space24)
        }
        .background(WenaColor.bgBase)
    }
}

#Preview("Light") {
    WenaActionButtonStylePreview()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    WenaActionButtonStylePreview()
        .preferredColorScheme(.dark)
}

#Preview("Larger Text") {
    WenaActionButtonStylePreview()
        .environment(\.dynamicTypeSize, .accessibility5)
}
#endif
