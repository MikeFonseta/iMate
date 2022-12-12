//
//  HomeView().swift
//  iMate
//
//  Created by Mike Fonseta on 12/12/22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var taskModel = sharedData
    
    @State var currentDayText = Date().formatted(date: .abbreviated, time: .omitted)
    
    @State var newTask = false
    
    @Namespace var animation
    
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false){
                LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]){
                    Section{
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 10){
                                ForEach(taskModel.currentWeek, id: \.self){ day in
                                    VStack(spacing: 10){
                                        Text(taskModel.extractDate(date: day, format: "dd")).font(.system(size: 14))
                                            .fontWeight(.semibold)
                                        
                                        Text(taskModel.extractDate(date: day, format: "EEE")).font(.system(size: 15))
                                        
                                        Circle().fill(.white).frame(width: 8, height: 8)
                                            .opacity(taskModel.isToday(date: day) ? 1 : 0)
                                    }.foregroundStyle(taskModel.isToday(date: day) ? .primary : .tertiary)
                                        .foregroundColor(taskModel.isToday(date: day) ? Color.white : Color.black)
                                        .frame(width: 45, height: 90)
                                        .background{
                                            ZStack{
                                                if taskModel.isToday(date: day){ Capsule().fill(Color("petrolio")).matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                                }
                                            }
                                        }
                                        .contentShape(Capsule())
                                        .onTapGesture {
                                            withAnimation{
                                                taskModel.currentDay = day
                                                currentDayText = day.formatted(date: .abbreviated, time: .omitted)
                                            }
                                        }
                                }
                            }.padding(.horizontal)
                        }
                        
                        TaskView()
                        
                    } header: {
                        HeaderView().hLeading()
                    }
                }.padding(2)
            }.ignoresSafeArea(.container, edges: .top)
                .overlay(
                    NavigationLink(destination: SingleTask(editing: false), label: {Image(systemName: "plus").foregroundStyle(.white).padding().background(Color("petrolio"), in: Circle())}).padding(), alignment: .bottomTrailing)
        }
    }
    
    func TaskView()-> some View{
        LazyVStack(spacing: 25){
            if let tasks = taskModel.filteredTasks{
                if tasks.isEmpty{
                    Text("No tasks found!").font(.system(size: 16))
                        .fontWeight(.light)
                        .offset(y: 100)
                }
                else{
                    ForEach(tasks){ task in
                        TaskCardView(task: task)
                    }
                }
            }else{
                ProgressView().offset(y: 100)
            }
        }
        .padding()
        .padding(.top)
        .onChange(of: taskModel.currentDay){ newValue in
            taskModel.filterTodayTasks()
            
        }
    }
    
    func TaskCardView(task: TaskModel)-> some View{
        HStack(alignment: .top, spacing: 30){
          
            VStack(spacing: 4){
                HStack(alignment: .top, spacing: 10){
                    VStack(alignment: .leading, spacing: 12){
                        HStack{     Text(task.taskTitle).font(.title2.bold())
                          task.taskImage.resizable().frame(width:30 , height:30)
                        }
                        Text(task.taskDescription).font(.callout).foregroundStyle(.secondary)
                    }.hLeading()
                    
                    Text(task.taskDate.formatted(date: .omitted, time: .shortened))
                    
                }
                
                    var task = task
                    HStack(spacing: 0){
                        HStack(spacing: 5){
                            if(task.user != ""){
                                Image(systemName: "person.fill")
                                Text(task.user)
                            }
                        }.hLeading()
                        
                        Button{
                            task.isCompleted = true
                        } label: {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle.fill")
                                .padding(10)
                        }
                    }.padding(.top)
            }
            .foregroundColor(.white)
            .padding(15)
            .padding(.bottom,0)
            .hLeading()
            .background(Color("petrolio").cornerRadius(25)
                .opacity(1))
        }.hLeading()
    }
    
    
    func HeaderView()->some View{
        HStack(spacing: 10){
            Text(currentDayText).foregroundColor(Color.black).font(Font.title)
                
            Spacer()
            
            NavigationLink(destination: Text("House Info")){ //HouseInfoView()) {
                Image(systemName: "person.2.fill").foregroundColor(Color("petrolio"))
            }
    
            
        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(Color.white)
    }
}

extension View{
    
    func hLeading()-> some View{
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing()-> some View{
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter()-> some View{
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
