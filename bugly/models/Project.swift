//
//  Project.swift
//  bugly
//
//  Created by Nikolaj Johannes Skole Jensen on 05/03/2024.
//

import Foundation
import SwiftData

@Model
final class Project {
    @Attribute(.unique) var label: String
    var note: String
    var timestamp: Date
    
    @Relationship(deleteRule: .cascade, inverse: \Issue.project)
    var issues: [Issue]
    
    init(label: String) {
        self.label = label
        self.note = ""
        self.issues = []
        self.timestamp = Date.now
    }
}
