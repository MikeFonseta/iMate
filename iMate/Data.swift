//
//  File.swift
//  iMate
//
//  Created by Mike Fonseta on 12/12/22.
//

import SwiftUI

class SharedData: ObservableObject{
    
    @Published var user = User(username: "mike", hasHouse: true)
    //@Published var user = User(username: "isabella", hasHouse: false)
    
    
    @Published var house = House(code: "13m17", name: "Penguin's house", description: "Bhoo", members: [
        User(username: "mike", hasHouse: true),
        User(username: "mariam", hasHouse: true),
        User(username: "cristina", hasHouse: true),
        User(username: "antonio", hasHouse: true),
        User(username: "davide", hasHouse: true)], owener: User(username: "mike", hasHouse: true))

    //TaskSection
    @Published var storedTasks: [TaskModel] = [TaskModel(taskTitle: "Study", taskDescription: "Math", taskDate: .init(timeIntervalSince1970: 1670503859),user: "mike", isCompleted: false)]
    
    @Published var currentWeek: [Date] = []
    @Published var currentDay = Date()
    
    @Published var filteredTasks: [TaskModel]?
    
    init(){
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    func filterTodayTasks(){
        DispatchQueue.global(qos: .userInteractive).async {
            
            let calendar = Calendar.current
            let filtered = self.storedTasks.filter{
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }.sorted{ task1, task2 in
                return task2.taskDate < task1.taskDate
            }
            
            DispatchQueue.main.async {
                withAnimation{
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek(){
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekOfDay = week?.start else{
            return
        }
        
        (1...28).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day,to: firstWeekOfDay){
                currentWeek.append(weekDay)
            }
        }
    }
    
    func extractDate(date: Date, format: String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func isToday(date: Date)->Bool{
        let calendaer = Calendar.current
        
        return calendaer.isDate(currentDay, inSameDayAs: date)
    }
    
    func isCurrentHour(date: Date)-> Bool{
        
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }
}

var sharedData = SharedData()
