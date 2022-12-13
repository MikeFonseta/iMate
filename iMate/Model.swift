//
//  Model.swift
//  iMate
//
//  Created by Mike Fonseta on 12/12/22.
//

import SwiftUI

struct TaskModel: Identifiable{
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
    var user: String
    var isCompleted: Bool
    var taskIcon: String
}

struct User: Identifiable{
    var id = UUID().uuidString
    var username: String
    var hasHouse: Bool
}

struct House: Identifiable{
    var id = UUID().uuidString
    var code: String
    var name: String
    var description: String
    var members: [User]
    var owener: User
}

class HouseCodeModel: ObservableObject{
    @Published var codeText = ""
    @Published var codeFields: [String] = Array(repeating: "", count: 5)
}
