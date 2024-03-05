//
//  Prefs.swift
//  bugly
//
//  Created by Nikolaj Johannes Skole Jensen on 05/03/2024.
//

import Foundation
import SwiftUI
import Defaults

// MARK: store

public let userDefaults = UserDefaults(suiteName: "group.com.nikolajjsj.bugly")!




// MARK: Defaults setup

extension Defaults.Keys {
    static let theme = Key<Theme>("default-theme", default: Theme.automatic, suite: userDefaults)
}


// MARK: Enums

enum Theme: String, CaseIterable, Defaults.Serializable {
    case automatic = "Automatic"
    case light = "Light"
    case dark = "Dark"
    
    static let defaultValue = Theme.automatic
    
    var colorScheme: ColorScheme? {
        switch self {
        case .automatic:
            return nil
        case .dark:
            return .dark
        case .light:
            return .light
        }
    }
}
