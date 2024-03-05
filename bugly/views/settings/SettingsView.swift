//
//  SettingsView.swift
//  bugly
//
//  Created by Nikolaj Johannes Skole Jensen on 05/03/2024.
//

import SwiftUI
import Defaults

struct SettingsView: View {
    @Default(.theme) private var theme
    
    var body: some View {
        NavigationStack {
            List {
                Picker("Theme", selection: $theme) {
                    ForEach(Theme.allCases, id: \.self) { t in
                        Text(t.rawValue).tag(t)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
