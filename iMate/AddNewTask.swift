//
//  SingleTask.swift
//  iMate
//
//  Created by Mike Fonseta on 12/12/22.
//

import SwiftUI

struct AddNewTask: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var title: String = ""
    @State var description: String = ""
    @State var date: Date = Date()
    @State var selectedIcon: String = "bed.double.circle"
    @State var showRandomAssign = false
    @State var showingAlert = false
    @State var assignedUser: String = "Nobody"

    @State var users = ["Nobody","Mike","Antonio","Mariam","Cristina","Davide","Isabella"]
    
    @ObservedObject var taskModel = sharedData
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("", text: $title)
                } header: {
                    Text("Title")
                }
                Section(header: Text("icon")){
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 10){
                            ForEach(taskModel.taskIcons, id: \.self) { taskIcon in
                                Icon(icon: taskIcon, selectedIcon: self.$selectedIcon)
                            }
                        }.padding(20)
                    }.padding(-20)
                }
                
                Picker("Assigned to", selection: $assignedUser) {
                    ForEach(users, id: \.self) { user in
                        Text(user)
                    }
                }
                .pickerStyle(.menu)
                
                HStack{
                    Spacer()
                    Text("Assign Random").foregroundColor(Color("petrolio"))
                    Image("Wheel").resizable().frame(width: 20,height: 20)
                    Spacer()
                }.onTapGesture {
                    showRandomAssign = true
                }
                
                Section{
                    
                    TextField("", text: $description,  axis: .vertical).lineLimit(5...5)
                    
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
                        Button("Add"){
                                taskModel.storedTasks.append(TaskModel(taskTitle: title, taskDescription: description, taskDate: date, user: assignedUser != "Nobody" ? assignedUser: "Nobody", isCompleted: false, taskIcon: selectedIcon))
                                
                                taskModel.filterTodayTasks()
                                presentationMode.wrappedValue.dismiss()
                            }.disabled(title == "")
                    }
                }
                .sheet(isPresented: $showRandomAssign){
                    AssignmentModal(assignedUser: $assignedUser, showRandomAssign: $showRandomAssign)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Are you sure you want to delete this task"),primaryButton: .destructive(Text("Delete")) {
                        print("Deleting...")
                    },
                          secondaryButton: .cancel(){
                        showRandomAssign = false
                    })
                }
        }
    }
    
    struct Icon: View {

        let icon: String
        @Binding var selectedIcon: String

        var body: some View {
            Image(systemName: icon == selectedIcon ? icon+".fill" : icon)
                .resizable()
                .frame(width:40,height:40)
                .foregroundStyle(Color("petrolio"))
                .onTapGesture {
                    self.selectedIcon = self.icon
                }.padding(16)
        }
    }
}

struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
    }
}
