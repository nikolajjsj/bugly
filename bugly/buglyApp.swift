//
//  buglyApp.swift
//  bugly
//
//  Created by Nikolaj Johannes Skole Jensen on 05/03/2024.
//

import SwiftUI
import SwiftData
import Defaults

@main
struct buglyApp: App {
    @Default(.theme) private var theme
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Project.self, Issue.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            AppView()
                .preferredColorScheme(theme.colorScheme)
        }
        .modelContainer(sharedModelContainer)
    }
}
