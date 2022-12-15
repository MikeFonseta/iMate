//
//  File.swift
//  iMate
//
//  Created by Mike Fonseta on 12/12/22.
//

import SwiftUI

class SharedData: ObservableObject{
    
    @Published var user = User(username: "Mike", hasHouse: true)
    //@Published var user = User(username: "isabella", hasHouse: true)
    
    @Published var taskIcons = ["bed.double.circle","fork.knife.circle","toilet.circle","trash.circle","pawprint.circle","popcorn.circle","calendar.circle","dollarsign.circle"]
    
    @Published var house = House(code: "13m17", name: "Penguins", description: "Penguins never leave a penguin", members: [
        User(username: "Mike", hasHouse: true),
        User(username: "Mariam", hasHouse: true),
        User(username: "Cristina", hasHouse: true),
        User(username: "Antonio", hasHouse: true),
        User(username: "Davide", hasHouse: true),
        User(username: "Isabella", hasHouse: true)], owener: User(username: "Mike", hasHouse: true))

    //TaskSection
    @Published var storedTasks: [TaskModel] = []
    
    @Published var currentWeek: [Date] = []
    @Published var currentDay = Date()
    @Published var today = Date()
    
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
        
        (1...7).forEach { day in
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
    
    func checkTheDay(date: Date)->Bool{
        let calendaer = Calendar.current
        return calendaer.isDate(currentDay, inSameDayAs: date)
    }
    
    func isToday(date: Date)->Bool{
        let calendaer = Calendar.current
        return calendaer.isDate(today, inSameDayAs: date)
    }
    

}

var sharedData = SharedData()
