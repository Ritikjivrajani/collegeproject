//
//  NewContactScreen.swift
//  CollegeProject
//
//  Created by karishma on 11/12/23.
//

import SwiftUI

struct NewContactScreen: View {
    @State private var searchText = ""
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    Section{
                        NavigationLink{
                            
                        } label: {
                            Text("New Group")
                                .foregroundStyle(.blue)
                                .font(.title3)
                        }
                        
                        Button("Send"){
                            contactfetch().fetchApi(name: "Karishma", contact: "123456789")
                        }
                    }
                    
                    Section{
                        ForEach(0...10, id: \.self){ contact in
                            HStack{
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading){
                                    Text("contact \(contact)")
                                        .font(.system(size: 20))
                                        .fontWeight(.heavy)
                                    Text("caption")
                                        .foregroundStyle(.gray)
                                        .font(.headline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("New Chats")
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar{
//                ToolbarItem{
//                    Button("✖️"){
//                        
//                    }
//                }
//            }
        }
    }
}

#Preview {
    NewContactScreen()
}
