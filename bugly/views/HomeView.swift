//
//  HomeView.swift
//  bugly
//
//  Created by Nikolaj Johannes Skole Jensen on 05/03/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var query = ""
    @State private var settings = false
    
    var body: some View {
        ProjectList(query: query)
            .navigationTitle("Bugly")
            .searchable(text: $query)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Settings", systemImage: "gear") {
                        settings.toggle()
                    }
                }
            }
            .sheet(isPresented: $settings) { SettingsView() }
    }
}

fileprivate struct ProjectList: View {
    @Environment(\.modelContext) private var context
    
    @Query private var projects: [Project]
    @State private var createProject = false
    
    init(query: String) {
        self._projects = Query(
            FetchDescriptor<Project>(
                predicate: #Predicate {
                    (query.isEmpty || $0.label.contains(query) || $0.note.contains(query))
                },
                sortBy: [SortDescriptor(\Project.label, comparator: .localizedStandard)]
            ),
            animation: .default
        )
    }
    
    var body: some View {
        List {
            if projects.isEmpty {
                ContentUnavailableView {
                    Label("No projects", systemImage: "folder.badge")
                } description: {
                    Text("You haven't created any new projects yet")
                } actions: {
                    Button("Add Project") {
                        createProject.toggle()
                    }
                }
            } else {
                Section("Projects") {
                    ForEach(projects) { project in
                        NavigationLink(value: Route.project(project)) {
                            Text(project.label)
                        }
                    }
                    .onDelete(perform: deleteProject)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Project", systemImage: "folder.badge.plus") {
                    createProject.toggle()
                }
            }
        }
        .sheet(isPresented: $createProject) { CreateProject() }
    }
    
    private func deleteProject(_ idxSet: IndexSet) {
        for idx in idxSet {
            let project = projects[idx]
            context.delete(project)
        }
    }
}

#Preview {
    HomeView()
}
