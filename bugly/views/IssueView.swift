//
//  IssueView.swift
//  bugly
//
//  Created by Nikolaj Johannes Skole Jensen on 05/03/2024.
//

import SwiftUI

struct IssueView: View {
    @Bindable var issue: Issue
    @FocusState var isInputActive: Bool
    
    var body: some View {
        List {
            Section("Details") {
                HStack {
                    Text("Date")
                    Spacer()
                    Text(issue.timestamp, format: .dateTime)
                }
                
                Picker("Status", selection: $issue.status) {
                    ForEach(IssueStatus.allCases, id: \.label) { s in
                        Text(s.label).tag(s)
                    }
                }
            }
            
            Section("Note") {
                TextField("Feature/Bugfix/etc.", text: $issue.note, axis: .vertical)
                    .focused($isInputActive)
                    .lineLimit(5...)
            }
        }
        .navigationTitle(issue.label)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isInputActive = false
                }
            }
        }
    }
}
