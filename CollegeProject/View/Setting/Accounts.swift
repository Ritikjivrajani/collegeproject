//
//  Accounts.swift
//  CollegeProject
//
//  Created by karishma on 24/11/23.
//

import SwiftUI

struct Accounts: View {
    @State private var profilePicture: String = "person.circle"
    @State private var userName: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var contact: String = ""
    var body: some View {
        NavigationView {
            ZStack{
                BackGroundView()
                VStack{
                    VStack{
                        Image(systemName: profilePicture)
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        Text("Enter Your Details")
                            .font(.title2)
                    }
                    
                    VStack(alignment: .leading, spacing: 20){
                        TextFieldView(fieldData: $userName, placeholderText: "Update User Name...")
                    
                        TextFieldView(fieldData: $firstName, placeholderText: "Update First Name...")
                        
                        TextFieldView(fieldData: $lastName, placeholderText: "Update Last Name...")
                        
                        TextFieldView(fieldData: $contact, placeholderText: "Update Contact Number...")
                        
                        Button {
                            
                        } label: {
                            Text("Update Profile")
                                .font(.title2)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 300, height: 50)
                                .background(.black)
                                .cornerRadius(30)
                        }

                    }
                    .frame(width: 350, height: 350)
                    .background(.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.bottom, 75)
                    .offset(y: 70)
                }
            }
        }
        .navigationTitle("Accounts")
    }
}

struct Accounts_Previews: PreviewProvider {
    static var previews: some View {
        Accounts()
    }
}
