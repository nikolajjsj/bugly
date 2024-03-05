//
//  CreateIssue.swift
//  bugly
//
//  Created by Nikolaj Johannes Skole Jensen on 05/03/2024.
//

import SwiftUI
import SwiftData

struct CreateIssue: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: [SortDescriptor(\Project.label, comparator: .localizedStandard)], animation: .default) private var projects: [Project]
    
    @State private var label = ""
    @State private var note = ""
    @State var selectedProject: Project
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Label", text: $label)
                    
                    TextField("Feature/Bugfix/etc.", text: $note, axis: .vertical)
                        .lineLimit(5...)
                }
                
                Section("Project") {
                    Picker("Selected project", selection: $selectedProject) {
                        ForEach(projects) { p in
                            Text(p.label).tag(p)
                        }
                    }
                }
            }
            .navigationTitle("Create Issue")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel, action: { dismiss() })
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Done", action: addIssue)
                }
            }
        }
        .presentationDetents([.medium])
    }
    
    private func addIssue() {
        guard !label.isEmpty else { dismiss(); return }
        
        let issue = Issue(label: label, note: note, project: selectedProject)
        context.insert(issue)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            dismiss()
        }
    }
}
