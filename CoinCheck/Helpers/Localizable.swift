//
//  Localizable.swift
//  CoinCheck
//
//  Created by Anibal Ventura on 4/1/22.
//

import Foundation

struct Localizable {
    static func lastUpdate(_ time: String) -> String {
        String(format: NSLocalizedString("last-update %@", comment: "When was the last time the price was updated."), time)
    }
    
    static let alertTitle: String = NSLocalizedString("alert-title", comment: "Title of alert when there is a error.")
    static func alertMessage(_ error: String) -> String {
        String(format: NSLocalizedString("alert-message %@", comment: "Message of alert when there is a error."), error)
    }
    static let alertButton: String = NSLocalizedString("alert-button", comment: "Button of alert when there is a error.")
}
