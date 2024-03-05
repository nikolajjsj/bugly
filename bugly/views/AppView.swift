//
//  AppView.swift
//  bugly
//
//  Created by Nikolaj Johannes Skole Jensen on 05/03/2024.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        NavigationStack {
            HomeView()
                .navigationDestination(for: Route.self, destination: destination)
        }
    }
    
    @ViewBuilder
    private func destination(_ route: Route) -> some View {
        switch route {
        case .project(let project):
            ProjectView(project: project)
        case .issue(let issue):
            IssueView(issue: issue)
        }
    }
}

enum Route: Hashable {
    case project(_ project: Project)
    case issue(_ issue: Issue)
}

#Preview {
    AppView()
}
