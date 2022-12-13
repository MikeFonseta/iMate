//
//  ModifyTask.swift
//  iMate
//
//  Created by Mike Fonseta on 13/12/22.
//

import SwiftUI

struct ModifyTask: View {
    
    var taskIndex: Int
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var title: String = ""
    @State var description: String = ""
    @State var date: Date = Date()
    @State var selectedIcon: String = "bed.double.circle"
    @State var showRandomAssign = false
    @State var showingAlert = false
    @State var assignedUser: String = "Nobody"
    

    @State var users = ["Nobody","mike","antonio","mariam","cristina","davide","isabella"]
    
    @ObservedObject var taskModel = sharedData
    
    init(taskIndex: Int,title: String,description: String, date: Date, selectedIcon: String, assignUser: String){
        self.taskIndex = taskIndex
        self._title = State(wrappedValue: title)
        self._description = State(wrappedValue: description)
        self._date = State(wrappedValue: date)
        self._selectedIcon = State(wrappedValue: selectedIcon)
        self._assignedUser = State(wrappedValue: assignUser)
    }
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("", text: $title)
                } header: {
                    Text("Title")
                }
                Section(header: Text("icon")){
                    HStack{
                        ForEach(taskModel.taskIcons, id: \.self) { taskIcon in
                            Icon(icon: taskIcon, selectedIcon: self.$selectedIcon)
                        }
                    }
                    
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
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button("Delete"){
                            showingAlert = true
                            }
                            .foregroundColor(Color.red)
                    }
                }
                .sheet(isPresented: $showRandomAssign){
                    AssignmentModal(assignedUser: $assignedUser, showRandomAssign: $showRandomAssign)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Are you sure you want to delete this task"),primaryButton: .destructive(Text("Delete")) {
                        
                        let taskToDelete = taskModel.filteredTasks![taskIndex]
                        let indexToDelete = taskModel.storedTasks.firstIndex(where: { $0.id == taskToDelete.id
                        })!
                        taskModel.filteredTasks?.remove(at: taskIndex)
                        taskModel.storedTasks.remove(at: indexToDelete)
                        taskModel.filterTodayTasks()
                        presentationMode.wrappedValue.dismiss()
                    },
                        secondaryButton: .cancel(){
                        showingAlert = false
                    })
                }
            
                .onChange(of: title, perform: { value in
                    if title != taskModel.storedTasks[taskIndex].taskTitle{
                        taskModel.storedTasks[taskIndex].taskTitle = title
                        taskModel.filterTodayTasks()
                    }
                })
                .onChange(of: description, perform: { value in
                    if description != taskModel.storedTasks[taskIndex].taskDescription{
                        taskModel.storedTasks[taskIndex].taskDescription = description
                        taskModel.filterTodayTasks()
                    }
                })
                .onChange(of: date, perform: { value in
                    if date != taskModel.storedTasks[taskIndex].taskDate{
                        taskModel.storedTasks[taskIndex].taskDate = date
                        taskModel.filterTodayTasks()
                    }
                })
                .onChange(of: assignedUser, perform: { value in
                    if assignedUser != taskModel.storedTasks[taskIndex].user{
                        taskModel.storedTasks[taskIndex].user = assignedUser
                        taskModel.filterTodayTasks()
                    }
                })
                .onChange(of: selectedIcon, perform: { value in
                    if selectedIcon != taskModel.storedTasks[taskIndex].taskIcon{
                        taskModel.storedTasks[taskIndex].taskIcon = selectedIcon
                        taskModel.filterTodayTasks()
                    }
                })
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
                }
                .padding(18)
        }
    }
}

struct ModifyTask_Previews: PreviewProvider {
    static var previews: some View {
        ModifyTask(taskIndex: 0,title: "Titolo", description: "Descrizione", date: Date(), selectedIcon: "trash.circle", assignUser: "Nobody")
    }
}
