//
//  Task.swift
//  TaskManagement
//
//  Created by Antonio on 07/12/22.
//

import SwiftUI

struct Task: Identifiable{
    var id=UUID().uuidString
    var tasktitle: String = "Team"
    var taskdescription: String
    var taskdate: Date
    var taskicon: Image = Image(systemName: "lightbulb")
}
