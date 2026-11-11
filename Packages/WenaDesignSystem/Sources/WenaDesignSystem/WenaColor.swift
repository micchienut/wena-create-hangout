//
//  WenaColor.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import SwiftUI

/// Semantic names and resolved default-mode values from Figma’s Color collection.
/// Figma: tbb7mahFF6m6GgB1jeQJWR. Asset namespaces preserve the exact variable paths.
/// The file currently defines one mode per collection; branded dark values remain pending.
public enum WenaColor {
    /// color/bg/base → color/white/100
    public static let bgBase = Color("color/bg/base", bundle: .module)

    /// color/bg/surface → color/white/50
    public static let bgSurface = Color("color/bg/surface", bundle: .module)

    /// color/bg/muted → color/white/300
    public static let bgMuted = Color("color/bg/muted", bundle: .module)

    /// color/bg/brand → color/orange/500
    public static let bgBrand = Color("color/bg/brand", bundle: .module)

    /// color/bg/brand-subtle → color/orange/100
    public static let bgBrandSubtle = Color("color/bg/brand-subtle", bundle: .module)

    /// Orange Tint → color/orange/300
    public static let orangeTint = Color("color/orange/300", bundle: .module)

    public static let accentDarkOrange = Color("color/accent/dark-orange", bundle: .module)
    public static let accentGreen = Color("color/accent/green", bundle: .module)
    public static let accentPeach = Color("color/accent/peach", bundle: .module)
    public static let accentPink = Color("color/accent/pink", bundle: .module)
    public static let accentBlue = Color("color/accent/blue", bundle: .module)
    public static let accentRose = Color("color/accent/rose", bundle: .module)
    public static let accentYellow = Color("color/accent/yellow", bundle: .module)

    /// color/bg/inverse → color/ink/900
    public static let bgInverse = Color("color/bg/inverse", bundle: .module)

    /// color/text/primary → color/ink/900
    public static let textPrimary = Color("color/text/primary", bundle: .module)

    /// color/text/secondary → color/ink/500
    public static let textSecondary = Color("color/text/secondary", bundle: .module)

    /// color/text/disabled → color/ink/300
    public static let textDisabled = Color("color/text/disabled", bundle: .module)

    /// color/text/on-brand → color/ink/900
    public static let textOnBrand = Color("color/text/on-brand", bundle: .module)

    /// color/text/inverse → color/white/100
    public static let textInverse = Color("color/text/inverse", bundle: .module)

    /// color/border/default → color/white/500
    public static let borderDefault = Color("color/border/default", bundle: .module)

    /// color/border/strong → color/ink/900
    public static let borderStrong = Color("color/border/strong", bundle: .module)

    /// color/border/brand → color/orange/500
    public static let borderBrand = Color("color/border/brand", bundle: .module)

    /// color/icon/primary → color/ink/900
    public static let iconPrimary = Color("color/icon/primary", bundle: .module)

    /// color/icon/secondary → color/ink/500
    public static let iconSecondary = Color("color/icon/secondary", bundle: .module)

    /// color/icon/inverse → color/white/100
    public static let iconInverse = Color("color/icon/inverse", bundle: .module)

    /// color/status/info/base → color/info/500
    public static let statusInfoBase = Color("color/status/info/base", bundle: .module)

    /// color/status/info/subtle → color/info/100
    public static let statusInfoSubtle = Color("color/status/info/subtle", bundle: .module)

    /// color/status/info/strong → color/info/700
    public static let statusInfoStrong = Color("color/status/info/strong", bundle: .module)

    /// color/status/info/border → color/info/300
    public static let statusInfoBorder = Color("color/status/info/border", bundle: .module)

    /// color/status/warning/base → color/warning/500
    public static let statusWarningBase = Color("color/status/warning/base", bundle: .module)

    /// color/status/warning/subtle → color/warning/100
    public static let statusWarningSubtle = Color("color/status/warning/subtle", bundle: .module)

    /// color/status/warning/strong → color/warning/700
    public static let statusWarningStrong = Color("color/status/warning/strong", bundle: .module)

    /// color/status/warning/border → color/warning/300
    public static let statusWarningBorder = Color("color/status/warning/border", bundle: .module)

    /// color/status/danger/base → color/danger/500
    public static let statusDangerBase = Color("color/status/danger/base", bundle: .module)

    /// color/status/danger/subtle → color/danger/100
    public static let statusDangerSubtle = Color("color/status/danger/subtle", bundle: .module)

    /// color/status/danger/strong → color/danger/700
    public static let statusDangerStrong = Color("color/status/danger/strong", bundle: .module)

    /// color/status/danger/border → color/danger/300
    public static let statusDangerBorder = Color("color/status/danger/border", bundle: .module)

    /// color/status/success/base → color/success/500
    public static let statusSuccessBase = Color("color/status/success/base", bundle: .module)

    /// color/status/success/subtle → color/success/100
    public static let statusSuccessSubtle = Color("color/status/success/subtle", bundle: .module)

    /// color/status/success/strong → color/success/700
    public static let statusSuccessStrong = Color("color/status/success/strong", bundle: .module)

    /// color/status/success/border → color/success/300
    public static let statusSuccessBorder = Color("color/status/success/border", bundle: .module)

    /// color/text/on-accent/pink → color/accent-text/pink
    public static let textOnAccentPink = Color("color/text/on-accent/pink", bundle: .module)

    /// color/text/on-accent/blue → color/accent-text/blue
    public static let textOnAccentBlue = Color("color/text/on-accent/blue", bundle: .module)

    /// color/text/on-accent/yellow → color/accent-text/yellow
    public static let textOnAccentYellow = Color("color/text/on-accent/yellow", bundle: .module)

    /// color/text/on-accent/green → color/accent-text/green
    public static let textOnAccentGreen = Color("color/text/on-accent/green", bundle: .module)

    /// color/text/on-accent/peach → color/accent-text/peach
    public static let textOnAccentPeach = Color("color/text/on-accent/peach", bundle: .module)

    /// color/text/on-accent/rose → color/accent-text/rose
    public static let textOnAccentRose = Color("color/text/on-accent/rose", bundle: .module)

    /// color/text/on-accent/dark-orange → color/accent-text/dark-orange
    public static let textOnAccentDarkOrange = Color("color/text/on-accent/dark-orange", bundle: .module)

    /// color/text/on-accent/orange → color/accent-text/orange
    public static let textOnAccentOrange = Color("color/text/on-accent/orange", bundle: .module)

}
