//
//  WenaFontRegistration.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import CoreText
import Foundation
import UIKit

/// Registers package-owned fonts once per process, before font lookup or line-height measurement.
enum WenaFontRegistration {
    static func ensureRegistered() {
        let errors = registrationErrors
        assert(errors.isEmpty, errors.joined(separator: "\n"))
    }

    private static let registrationErrors: [String] = {
        let names = ["Fredoka-Medium", "Fredoka-SemiBold", "DMSans-Regular", "DMSans-Medium", "DMSans-Bold"]
        var errors: [String] = []

        for name in names {
            guard let url = Bundle.module.url(forResource: name, withExtension: "ttf", subdirectory: "Fonts") else {
                errors.append("Missing bundled font: \(name).ttf")
                continue
            }

            var error: Unmanaged<CFError>?
            let registered = CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error)
            let registrationError = error?.takeRetainedValue()
            let alreadyRegistered = registrationError.map {
                CFErrorGetDomain($0) as String == kCTFontManagerErrorDomain as String
                    && CFErrorGetCode($0) == CTFontManagerError.alreadyRegistered.rawValue
            } ?? false

            guard registered || alreadyRegistered else {
                errors.append("Unable to register \(name): \(String(describing: registrationError))")
                continue
            }
            guard UIFont(name: name, size: 17)?.fontName == name else {
                errors.append("Font lookup failed after registration: \(name)")
                continue
            }
        }
        return errors
    }()
}
