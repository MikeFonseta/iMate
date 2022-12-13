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
    @State var IsSelected: Bool = true
    @State var IsSelected1: Bool = false
    @State var IsSelected2: Bool = false
    @State var IsSelected3: Bool = false
    @State var showRandomAssign = false
    @State var assignedUser: String = "Nobody"
    
    @State var users = ["Nobody","mike","antonio","mariam","cristina","davide","isabella"]

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
                    HStack{
                        Button{
                            
                        } label:{
                            Image(systemName: IsSelected ?  "bed.double.circle.fill" : "bed.double.circle")
                                .resizable()
                                .frame(width:40,height:40)
                                .foregroundStyle(Color("petrolio"))
                                .onTapGesture {
                                    IsSelected=true
                                    IsSelected1=false
                                    IsSelected2=false
                                    IsSelected3=false
                                }
                        }.padding(18)
                        
                        Button{
                            
                        } label:{
                            Image(systemName: IsSelected1 ?  "toilet.circle.fill" : "toilet.circle")
                                .resizable()
                                .frame(width:40,height:40)
                                .foregroundStyle(Color("petrolio"))
                                .onTapGesture {
                                    IsSelected1=true
                                    IsSelected=false
                                    IsSelected2=false
                                    IsSelected3=false

                                }
                        }.padding(18)
                        
                        
                        Button{
                            
                        } label:{
                            Image(systemName: IsSelected2 ?  "fork.knife.circle.fill" : "fork.knife.circle")
                                .resizable()
                                .frame(width:40,height:40)
                                .foregroundStyle(Color("petrolio"))
                                .onTapGesture {
                                    IsSelected2=true
                                    IsSelected=false
                                    IsSelected1=false
                                    IsSelected3=false

                                }
                        }.padding(18)
                        
                        
                        
                        Button{
                            
                        } label:{
                            Image(systemName: IsSelected3 ?  "trash.circle.fill" : "trash.circle")
                                .resizable()
                                .frame(width:40,height:40)
                                .foregroundStyle(Color("petrolio"))
                                .onTapGesture {
                                    IsSelected3=true
                                    IsSelected=false
                                    IsSelected1=false
                                    IsSelected2=false
                                }
                        }.padding(18)
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
                                
                                taskModel.storedTasks.append(TaskModel(taskTitle: title, taskDescription: description, taskDate: date, user: assignedUser != "Nobody" ? assignedUser: "Nobody", isCompleted: false))
                
                                taskModel.filterTodayTasks()
                                presentationMode.wrappedValue.dismiss()
                            }.disabled(title == "")
                        }
                    }
                }
                .sheet(isPresented: $showRandomAssign){
                    AssignmentModal(assignedUser: $assignedUser, showRandomAssign: $showRandomAssign)
                }
        }
    }
}

struct SingleTask_Previews: PreviewProvider {
    static var previews: some View {
        SingleTask(editing: true)
    }
}
