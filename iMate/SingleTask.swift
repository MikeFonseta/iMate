//
//  SingleTask.swift
//  iMate
//
//  Created by Mike Fonseta on 12/12/22.
//

import SwiftUI

struct SingleTask: View {
    
    var editing: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var title: String = ""
    @State var description: String = ""
    @State var date: Date = Date()
    
    @ObservedObject var taskModel = sharedData
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("", text: $title)
                } header: {
                    Text("Title")
                }
                Section{
                
                    TextField("", text: $description)
                    
                } header: {
                    Text("Icon")
                }
                Section{
                
                    TextField("", text: $description)
                    
                } header: {
                    Text("Description")
                }
                
                Section{
                    DatePicker("", selection: $date).datePickerStyle(.graphical).labelsHidden()
                } header: {
                    Text("Date")
                }
            }.listStyle(.insetGrouped)
                .navigationTitle("Add new task")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        if editing{
                            Button("Delete"){
                                taskModel.filterTodayTasks()
                            }.disabled(title == "").foregroundColor(Color.red)
                        }
                        else{
                            Button("Save"){
                                
                                taskModel.storedTasks.append(TaskModel(taskTitle: title, taskDescription: description, taskDate: date, user: "", isCompleted: false))
                
                                taskModel.filterTodayTasks()
                                presentationMode.wrappedValue.dismiss()
                            }.disabled(title == "")
                        }
                    }
                }
        }
    }
}

struct SingleTask_Previews: PreviewProvider {
    static var previews: some View {
        SingleTask(editing: true)
    }
}
