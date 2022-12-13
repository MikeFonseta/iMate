//
//  AssignmentModal.swift
//  iMate
//
//  Created by Mike Fonseta on 13/12/22.
//

import SwiftUI
import FortuneWheel

struct AssignmentModal: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var myData = sharedData
    
    @Binding var assignedUser: String
    @Binding var showRandomAssign: Bool
    
    @State var showingAlert: Bool = false
    @State var selected: Int = 0
    @State var users = ["mike","antonio","mariam","cristina","davide","isabella"]
    

    var body: some View {
        NavigationView{
            VStack(){
                Spacer()
                FortuneWheel(titles: ["mike","antonio","mariam","cristina","davide","isabella"], size: 320, onSpinEnd: { index in
                    selected = index
                    showingAlert = true
                    assignedUser = users[index]
                })
                Spacer()
                Text("Swipte to spin wheel")
                Spacer()
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Housemate has been assigned"), message: Text("It's \(users[selected])'s turn"), dismissButton: .default(Text("OK")){
                            showRandomAssign = false
                        })
                    }
                    .onDisappear{
                        print("Disappear")
                    }
            }
            .navigationTitle("Random assignment")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button("Cancel"){
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
        }
    }
}

