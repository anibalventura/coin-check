//
//  Localizable.swift
//  CoinCheck
//
//  Created by Anibal Ventura on 4/1/22.
//

import Foundation

struct Localizable {
    static func lastUpdate(_ time: String) -> String {
        String(format: NSLocalizedString("last-update %@", comment: ""), time)
    }

    static let alertTitle: String = NSLocalizedString("alert-title", comment: "")
    static func alertMessage(_ error: String) -> String {
        String(format: NSLocalizedString("alert-message %@", comment: ""), error)
    }
    static let alertButton: String = NSLocalizedString("alert-button", comment: "")
}
