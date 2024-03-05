//
//  Issue.swift
//  bugly
//
//  Created by Nikolaj Johannes Skole Jensen on 05/03/2024.
//

import Foundation
import SwiftData

@Model
final class Issue {
    var label: String
    var note: String
    var status: IssueStatus
    var timestamp: Date
    
    @Relationship var project: Project
    
    init(label: String, note: String, project: Project) {
        self.label = label
        self.note = note
        self.status = .initial
        self.project = project
        self.timestamp = Date.now
    }
}

enum IssueStatus: Codable, CaseIterable {
    case initial
    case cancelled
    case completed
    
    var label: String {
        switch self {
        case .initial:
            return "Initial"
        case .cancelled:
            return "Cancelled"
        case .completed:
            return "Completed"
        }
    }
}
