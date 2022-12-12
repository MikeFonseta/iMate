//
//  SwiftUIView.swift
//  TaskManagement
//
//  Created by Antonio on 09/12/22.
//

import SwiftUI

struct SwiftUIView: View {
    @Binding var isSelected: Bool
    @State var color: Color
    @State var mage: Image = Image(systemName: "lightbulb")

    var body: some View {
        ZStack{
            Image(systemName: "lightbulb")
                .resizable()
                .frame(width: 40, height: 50)
                .background()
                
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(isSelected: .constant(false), color: .blue)
    }
}
