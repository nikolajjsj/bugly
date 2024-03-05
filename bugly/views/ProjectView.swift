//
//  ProjectView.swift
//  bugly
//
//  Created by Nikolaj Johannes Skole Jensen on 05/03/2024.
//

import SwiftUI
import SwiftData

struct ProjectView: View {
    @Bindable var project: Project
    
    @State private var query = ""
    
    var body: some View {
        IssuesList(project: project, query: query)
            .navigationTitle(project.label)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $query)
    }
}

fileprivate struct IssuesList: View {
    @Environment(\.modelContext) private var context
    
    @Query private var issues: [Issue]
    
    private var project: Project
    @State private var createIssue = false
    
    init(project: Project, query: String) {
        self.project = project
        
        let projectLabel = project.label
        self._issues = Query(
            FetchDescriptor<Issue>(
                predicate: #Predicate {
                    $0.project.label == projectLabel
                    &&
                    (query.isEmpty || $0.label.contains(query) || $0.note.contains(query))
                },
                sortBy: [SortDescriptor(\Issue.timestamp)]
            ),
            animation: .default
        )
    }
    
    
    var body: some View {
        List {
            if issues.isEmpty {
                ContentUnavailableView {
                    Label("No issues", systemImage: "ant")
                } description: {
                    Text("You haven't added any issues to \(project.label)")
                } actions: {
                    Button("Add Issue") {
                        createIssue.toggle()
                    }
                }
            } else {
                Section("Issues") {
                    ForEach(issues) { issue in
                        NavigationLink(value: Route.issue(issue)) {
                            IssueRow(issue)
                        }
                    }
                    .onDelete(perform: deleteIssue)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Issue", systemImage: "square.and.pencil") {
                    createIssue.toggle()
                }
            }
        }
        .sheet(isPresented: $createIssue) { CreateIssue(selectedProject: project) }
    }
    
    private func deleteIssue(_ idxSet: IndexSet) {
        for idx in idxSet {
            let issue = issues[idx]
            context.delete(issue)
        }
    }
}
