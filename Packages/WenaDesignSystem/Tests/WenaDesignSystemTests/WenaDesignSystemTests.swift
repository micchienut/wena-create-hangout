//
//  WenaDesignSystemTests.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import SwiftUI
import Testing
import UIKit
import WenaDesignSystem

@Suite(.serialized)
@MainActor
struct WenaDesignSystemTests {
    @Test("Package color namespaces resolve with Figma values")
    func semanticColorsResolveFromPackage() throws {
        let samples: [(Color, CGFloat, CGFloat, CGFloat)] = [
            (WenaColor.bgBase, 255 / 255, 251 / 255, 239 / 255),
            (WenaColor.textPrimary, 38 / 255, 22 / 255, 7 / 255),
            (WenaColor.bgBrand, 255 / 255, 152 / 255, 49 / 255),
            (WenaColor.statusDangerBase, 214 / 255, 69 / 255, 69 / 255),
            (WenaColor.textOnAccentPink, 0.1895945966, 0.0404054038, 0.1165540516)
        ]
        for (color, red, green, blue) in samples {
            var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
            #expect(UIColor(color).getRed(&r, green: &g, blue: &b, alpha: &a))
            #expect(abs(r - red) < 0.001)
            #expect(abs(g - green) < 0.001)
            #expect(abs(b - blue) < 0.001)
            #expect(abs(a - 1) < 0.001)
        }
    }

    @Test("Font helpers register all package fonts without UIAppFonts")
    func fontRegistrationIsAutomaticAndRepeatable() throws {
        _ = WenaFont.font(.body)
        _ = WenaFont.font(.largeTitle, emphasized: true)
        _ = WenaFont.font(.body)

        for name in ["DMSans-Regular", "DMSans-Medium", "DMSans-Bold", "Fredoka-Medium", "Fredoka-SemiBold"] {
            let font = try #require(UIFont(name: name, size: 17))
            #expect(font.fontName == name)
        }
    }

    @Test("Packaged typography still grows at accessibility text sizes")
    func typographyScalesWithDynamicType() {
        let regular = UIHostingController(rootView:
            Text(verbatim: "Sample").wenaTypography(.body).environment(\.dynamicTypeSize, .large)
        )
        let accessible = UIHostingController(rootView:
            Text(verbatim: "Sample").wenaTypography(.body).environment(\.dynamicTypeSize, .accessibility5)
        )
        let bounds = CGSize(width: 1_000, height: 1_000)
        let regularSize = regular.sizeThatFits(in: bounds)
        let accessibleSize = accessible.sizeThatFits(in: bounds)
        #expect(regularSize.height > 0)
        #expect(accessibleSize.height > regularSize.height)
        #expect(accessibleSize.width > regularSize.width)
    }
}
