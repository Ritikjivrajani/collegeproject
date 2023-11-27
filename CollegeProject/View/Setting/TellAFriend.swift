//
//  SwiftUIView.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 27/11/23.
//

import SwiftUI

struct TellAFriend: View {
    var body: some View {
        NavigationView{
            ZStack{
                BackGroundView()
            }
            .navigationTitle("Tell a Friend")
        }
    }
}

#Preview {
    TellAFriend()
}
