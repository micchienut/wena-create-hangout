//
//  WenaFont.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import SwiftUI

/// Figma 11:718: Fredoka for titles, DM Sans for reading text.
/// Names are the bundled fonts' verified PostScript names, not their file-family labels.
public enum WenaFont {
    public enum Style: String, CaseIterable, Identifiable {
        case largeTitle
        case title1
        case title2
        case title3
        case headline
        case body
        case callout
        case subheadline
        case footnote
        case caption1
        case caption2

        public var id: String { rawValue }

        var textStyle: Font.TextStyle {
            switch self {
            case .largeTitle: .largeTitle
            case .title1: .title
            case .title2: .title2
            case .title3: .title3
            case .headline: .headline
            case .body: .body
            case .callout: .callout
            case .subheadline: .subheadline
            case .footnote: .footnote
            case .caption1: .caption
            case .caption2: .caption2
            }
        }

        var pointSize: CGFloat {
            switch self {
            case .largeTitle: 34
            case .title1: 28
            case .title2: 22
            case .title3: 20
            case .headline: 17
            case .body: 17
            case .callout: 16
            case .subheadline: 15
            case .footnote: 13
            case .caption1: 12
            case .caption2: 11
            }
        }

        var lineHeight: CGFloat {
            switch self {
            case .largeTitle: 41
            case .title1: 34
            case .title2: 28
            case .title3: 25
            case .headline: 22
            case .body: 22
            case .callout: 21
            case .subheadline: 20
            case .footnote: 18
            case .caption1: 16
            case .caption2: 13
            }
        }

        var tracking: CGFloat {
            switch self {
            case .largeTitle: 0.4
            case .title1: 0.38
            case .title2: -0.26
            case .title3: -0.45
            case .headline: -0.43
            case .body: -0.43
            case .callout: -0.31
            case .subheadline: -0.23
            case .footnote: -0.08
            case .caption1: 0
            case .caption2: 0.06
            }
        }

        func fontName(emphasized: Bool = false) -> String {
            switch self {
            case .largeTitle, .title1, .title2, .title3:
                emphasized ? "Fredoka-SemiBold" : "Fredoka-Medium"
            case .headline:
                "DMSans-Medium"
            default:
                emphasized ? "DMSans-Medium" : "DMSans-Regular"
            }
        }
    }

    public static func font(_ style: Style, emphasized: Bool = false) -> Font {
        WenaFontRegistration.ensureRegistered()
        return .custom(style.fontName(emphasized: emphasized), size: style.pointSize, relativeTo: style.textStyle)
    }
}
