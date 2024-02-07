//
//  AdminView.swift
//  CollegeProject
//
//  Created by karishma on 06/02/24.
//

import SwiftUI

struct AdminView: View {
    @ObservedObject private var firebaseService = FirebaseService()
    @ObservedObject var block = register()

    var body: some View {
        
            ZStack {
                List {
                    Section {
                        ForEach(firebaseService.items, id: \.self) { item in
                            HStack {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 50, height: 50)

                                VStack(alignment: .leading) {
                                    Text("\(item.FirstName) \(item.LastName)")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                    Text("caption")
                                        .foregroundStyle(.gray)
                                        .font(.headline)
                                }

                                Spacer()

                                Button("Block") {
                                    print("Block \(item.FirstName) \(item.LastName)")
                                    
                                    block.isBlock = true
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .foregroundColor(.red)
                            }
                            .navigationTitle("Block users")
                            .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
    
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
