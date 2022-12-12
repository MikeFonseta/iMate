//
//  Home.swift
//  TaskManagement
//
//  Created by Antonio on 07/12/22.
//

import Foundation
import SwiftUI

struct Home: View {
    @StateObject var taskmodel: TaskViewModel = TaskViewModel()
    @State var newTaskisPresented: Bool = false
    
    @Namespace var animation
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.tintColor]
    }
    var body: some View {
        
        VStack {
            NavigationView{
                
                ZStack{
                    Color.blue.ignoresSafeArea().opacity(0)
                    ScrollView(.vertical, showsIndicators: false){
                        LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]){
                            Section{
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack(spacing: 10){
                                        ForEach(taskmodel.currentWeek,id: \.self){day in
                                            
                                            VStack(spacing: 10){
                                                Text(taskmodel.extractDate(date: day, format: "dd"))
                                                    .font(.system(size: 15)).fontWeight(.semibold)
                                                Text(taskmodel.extractDate(date: day, format: "EEE"))
                                                    .font(.system(size: 14))
                                                Circle()
                                                    .fill(.white)
                                                    .frame(width: 8,height: 8)
                                                    .opacity(taskmodel.isToday(date: day) ? 1 : 0)
                                            }
                                            .foregroundStyle(taskmodel.isToday(date: day) ? .primary : .secondary)
                                            .foregroundColor(taskmodel.isToday(date: day) ? .white : .black)
                                            .frame(width: 45, height: 90)
                                            .background{
                                                
                                                ZStack{
                                                    if taskmodel.isToday(date: day){
                                                        Capsule()
                                                            .fill(.blue)
                                                            .matchedGeometryEffect(id: "Current Day", in: animation)
                                                    }
                                                }
                                            }
                                            .contentShape(Capsule())
                                            .onTapGesture {
                                                withAnimation{
                                                    taskmodel.currentDay = day
                                                }
                                            }
                                            
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                TaskView()
                            }
                        header: {
                            
                            HeaderView()
                            
                        }.sheet(isPresented: $newTaskisPresented){
                            NewTaskView()
                        }
                        }
                        
                    }
                    .ignoresSafeArea(.container,edges: .top)
                    
                }
            }
            Button {
                newTaskisPresented.toggle()
            } label: {
                Image(systemName: "plus.circle.fill").resizable()
                    .frame(width:35,height:35)
                
            }.offset(x:155,y:-20)
            
        }
    }
    
    
    
    func TaskView()->some View{
        LazyVStack(spacing: 25){
            if let tasks = taskmodel.filteredTasks{
                if tasks.isEmpty{
                    Text("No Task Found!!!")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .offset(y:100)
                    
                }else{
                    ForEach(tasks){task in
                        TaskCardView(task: task)
                    }
                }
            }else{
                ProgressView()
                    .offset(y:100)
            }
        }
        .padding()
        .padding(.top)
        .onChange(of: taskmodel.currentDay){ newvalue in
            taskmodel.filteredtodaytasks()
            
        }
    }
    
    func TaskCardView(task: Task)->some View{
        
        HStack(alignment: .top, spacing: 30){
            VStack(spacing: 10){
                
                Button{
                    
                } label: {
                    task.taskicon
                        .frame(width: 65, height: 60)
                        .clipShape(Circle())
                        .background(Circle().stroke(.blue,lineWidth: 5))
                    
                    
                }
                
                
                .scaleEffect(taskmodel.isCurrentHour(date: task.taskdate) ? 0.8 : 1)
                /*  Rectangle()
                 .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                 .fill(.black)
                 .frame(width: 0.5)
                 */
            }
            VStack{
                
                HStack(alignment: .top, spacing: 10){
                    VStack(alignment: .leading, spacing: 12){
                        Text(task.tasktitle)
                            .font(.title2.bold())
                        Text(task.taskdescription).font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .HLeading()
                    
                    Text(task.taskdate.formatted(date: .omitted, time: .shortened))
                    
                    
                    
                }
                if taskmodel.isCurrentHour(date: task.taskdate){
                    HStack(spacing: 0){
                        HStack(spacing: -10){
                            ForEach(["User1","User2","User3"],id: \.self){ user in
                                Image(user)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())
                                    .background(Circle().stroke(.black,lineWidth: 5))
                            }
                        }.HLeading()
                        
                        Button{
                            
                        } label:{
                            Image(systemName: "checkmark")
                                .foregroundStyle(.black)
                                .padding(8)
                                .background(Color.white,in: RoundedRectangle(cornerRadius: 20))
                        }
                    }
                    .padding(.top)
                }
            }
            
            .foregroundColor(.black)
            .padding(taskmodel.isCurrentHour(date: task.taskdate) ? 15 : 0)
            .padding(.bottom,taskmodel.isCurrentHour(date: task.taskdate) ? 0 : 10)
        }.HLeading()
    }
    
    func HeaderView()->some View{
        
        
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 10){
                
            }
            .navigationTitle("Penguin")
            
            
            .HLeading()
            Button {
                
            } label: {
                Image("Profile").resizable().aspectRatio(contentMode: .fill).frame(width: 45,height: 45).clipShape(Circle()).offset(y:20)
            }
        }
        .padding()
        .padding(.top,getSafeArea().top)
        .background(Color.white)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
    
}

extension View{
    func HLeading()-> some View{
        self
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    func HTrailing()-> some View{
        self
            .frame(maxWidth: .infinity,alignment: .trailing)
    }
    func HCenter()-> some View{
        self
            .frame(maxWidth: .infinity,alignment: .center)
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

