//
//  IssueRow.swift
//  bugly
//
//  Created by Nikolaj Johannes Skole Jensen on 05/03/2024.
//

import SwiftUI

struct IssueRow: View {
    var issue: Issue
    
    init(_ issue: Issue) {
        self.issue = issue
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(issue.label)
                    .font(.body)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(issue.timestamp, style: .date)
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
            }
            
            Text(issue.note)
                .font(.footnote)
                .foregroundStyle(.gray)
                .lineLimit(1, reservesSpace: true)
        }
        .padding(.vertical, 4)
    }
}
