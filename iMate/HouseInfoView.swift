//
//  HouseInfoView.swift
//  iMate
//
//  Created by Mike Fonseta on 14/12/22.
//

import SwiftUI

struct HouseInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var myData = sharedData
    
    @State var description: String = ""
    
    init(){
        self._description = State(wrappedValue: myData.house.description)
    }
    
    
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Code")){
                    HStack{
                        Text(myData.house.code).textSelection(.enabled)
                    }
                }
                
                Section{
                    TextField("", text: $description,  axis: .vertical).lineLimit(5...5)
                    
                } header: {
                    Text("Description")
                }
                
                Section(header: Text("Housemates")){
                        ForEach(myData.house.members){ housemate in
                            HStack{
                                Text(housemate.username)
                                Spacer()
                                Text(housemate.username == myData.house.owener.username ? "Owner" : "").foregroundColor(.gray)
                            }
                        }
                }
            }.onChange(of: description, perform: { value in
                if description != myData.house.description{
                    myData.house.description = description
                }
            })
        }.navigationTitle(myData.house.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(myData.user.username == myData.house.owener.username ? "Delete" : "Leave"){
                    }.foregroundColor(Color.red)
                }
            }
    }
}

struct HouseInfoView_Previews: PreviewProvider {
    static var previews: some View {
        HouseInfoView()
    }
}
