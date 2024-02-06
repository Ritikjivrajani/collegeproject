//
//  UserData.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 06/02/24.
//

import SwiftUI

struct UserData: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var firebaseService = FirebaseService()
    var body: some View{
        NavigationView{
            ZStack{
                List{
                    Section {
                        ForEach(firebaseService.items, id: \.self){ item in
                            HStack{
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading){
                                    Text("\(item.FirstName) \(item.LastName)")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                    Text("caption")
                                        .foregroundStyle(.gray)
                                        .font(.headline)
                                }
                            }
                            .navigationTitle("New Chats")
                            .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    UserData()
}
