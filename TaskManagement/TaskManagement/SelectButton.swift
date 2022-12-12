//
//  SelectButton.swift
//  TaskManagement
//
//  Created by Antonio on 09/12/22.
//

import Foundation
import SwiftUI


import SwiftUI

struct SelectButtonView: View {
    @Binding var IsSelected : Bool
    @State var color : Color
    @State var text : String
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct SelectButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SelectButtonView()
    }
}
