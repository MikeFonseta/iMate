//
//  NewTask.swift
//  TaskManagement
//
//  Created by Antonio on 08/12/22.
//

import Foundation
import SwiftUI

struct NewTaskView: View {
    @ObservedObject var myData = sharedData
    @State var title: String = ""
    @State var description: String = ""
    @State  private var IsSelected: Bool = false
    @State var taskdate: Date = Date()

    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("title")){
                    TextField("task's name", text: $title)
                }
                Section(header: Text("icon")){
                    VStack{
                        
                        HStack{

                            Button{
                                
                            } label:{
                                Image(systemName: "frying.pan")
                                    .resizable()
                                    .frame(width:40,height:35)
                                .foregroundStyle(.black)
                                
                                    .padding(18)
                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 20))
                            }
                            
                            Button{
                                
                            } label:{
                                Image(systemName: "books.vertical") .resizable()
                                    .frame(width:40,height:35)
                                .foregroundStyle(.black)
                                
                                    .padding(18)
                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 20))
                            }
                       
                            Button{
                                
                            } label:{
                                Image(systemName:  "bed.double") .resizable()
                                    .frame(width:40,height:35)
                                .foregroundStyle(.black)
                                
                                    .padding(18)
                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 20))
                            }
                            Button{
                                
                            } label:{
                                Image(systemName: "cup.and.saucer") .resizable()
                                    .frame(width:40,height:35)
                                .foregroundStyle(.black)
                                
                                    .padding(18)
                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 20))
                            }
                        }.HLeading()
                
                        HStack{
                            Button{
                                
                            } label:{
                                Image(systemName: "shower.handheld") .resizable()
                                    .frame(width:40,height:35)
                                .foregroundStyle(.black)
                                
                                    .padding(18)
                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 20))
                            }
                            Button{
                                
                            } label:{
                                Image(systemName: "figure.run") .resizable()
                                    .frame(width:40,height:35)
                                .foregroundStyle(.black)
                                
                                    .padding(18)
                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 20))
                            }
                            Button{
                                
                            } label:{
                                Image(systemName: "sofa") .resizable()
                                    .frame(width:40,height:35)
                                .foregroundStyle(.black)
                                
                                    .padding(18)
                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 20))
                            }
                           
                            Button{
                                
                            } label:{
                                Image(systemName: "washer") .resizable()
                                    .frame(width:40,height:35)
                                .foregroundStyle(.black)
                                
                                    .padding(18)
                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 20))
                            }
                           
                        
                        }.HLeading()
                        
                        HStack{
                            Button{
                                
                            } label:{
                                Image(systemName: "cross.case") .resizable()
                                    .frame(width:40,height:35)
                                .foregroundStyle(.black)
                                
                                    .padding(18)
                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 20))
                            }
                           
                            Button{
                                
                            } label:{
                                Image(systemName: "car") .resizable()
                                    .frame(width:40,height:35)
                                .foregroundStyle(.black)
                                
                                    .padding(18)
                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 20))
                            }
                           
                            Button{
                                
                            } label:{
                                Image(systemName: "pawprint") .resizable()
                                    .frame(width:40,height:35)
                                .foregroundStyle(.black)
                                
                                    .padding(18)
                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 20))
                            }
                        }.HLeading()
                    }
                }
                Section(header: Text("description")){
                    TextField("task's description", text: $description)
                }
                    Section{
                        DatePicker("", selection: $taskdate)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    }
                
                
            }.navigationTitle("New Task")
               
                }
        }
    }

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
    }
}
