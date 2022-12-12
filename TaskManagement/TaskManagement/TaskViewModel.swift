//
//  TaskViewModel.swift
//  TaskManagement
//
//  Created by Antonio on 07/12/22.
//

import Foundation
import SwiftUI

class TaskViewModel: ObservableObject{
    @Published var storedTasks: [Task] = [
        Task(tasktitle: "wash dishes", taskdescription: "No Description", taskdate: .init(timeIntervalSince1970: 1670508000),taskicon: Image(systemName: "frying.pan")),
        Task(tasktitle: "study", taskdescription: "Try to study Software Engineering for the exam", taskdate: .init(timeIntervalSince1970: 1670572800),taskicon: Image(systemName: "books.vertical")),
        Task(tasktitle: "clean bathroom", taskdescription: "No Description", taskdate: .init(timeIntervalSince1970: 1670438404),taskicon: Image(systemName: "shower")),
        Task(tasktitle: "Wash the car", taskdescription: "go to Lorenzo's store", taskdate: .init(timeIntervalSince1970: 1670767200),taskicon: Image(systemName: "car")),
        Task(tasktitle: "Project Work", taskdescription: "Work on the project", taskdate: .init(timeIntervalSince1970: 1670767950)),
        Task(tasktitle: "Meeting", taskdescription: "discuss about the project", taskdate: .init(timeIntervalSince1970: 1670767350)),
        
        
    ]
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    @Published var filteredTasks: [Task]?
    
    init() {
        fetchCurrentWeek()
        filteredtodaytasks()
    }
    
    func filteredtodaytasks(){
        DispatchQueue.global(qos: .userInteractive).async{
            let calendar = Calendar.current
            let filtered = self.storedTasks.filter{
                return calendar.isDate($0.taskdate, inSameDayAs: self.currentDay)
            }
                .sorted{ task1, task2 in
                    return task1.taskdate < task2.taskdate
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
        guard let firstweekday = week?.start else{
            return
        }
        
        (1...7).forEach{ day in
            
            if let weekday = calendar.date(byAdding : .day, value : day, to: firstweekday){
                currentWeek.append(weekday)
            }
        }
    }
    
    
    
    
    func extractDate(date: Date,format: String)->String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    
    func isToday(date: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay,inSameDayAs: date)
    }
    
    func isCurrentHour(date: Date)->Bool{
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        return hour == currentHour
    }
    func isCurrentIcon(date: Date)->Bool{
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        return hour == currentHour
    }
    
}

var sharedData = TaskViewModel()
