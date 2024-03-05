//
//  CreateProject.swift
//  bugly
//
//  Created by Nikolaj Johannes Skole Jensen on 05/03/2024.
//

import SwiftUI

struct CreateProject: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var label = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Label", text: $label)
                }
            }
            .navigationTitle("Create Project")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel, action: { dismiss() })
                }
                
                ToolbarItem {
                    Button("Done", action: addProject)
                }
            }
        }
        .presentationDetents([.medium])
    }
    
    private func addProject() {
        guard !label.isEmpty else { dismiss(); return }
        
        let project = Project(label: label)
        context.insert(project)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            dismiss()
        }
    }
}

#Preview {
    CreateProject()
}
