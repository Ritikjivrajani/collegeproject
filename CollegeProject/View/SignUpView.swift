//
//  SignInView.swift
//  CollegeProject
//
//  Created by karishma on 13/11/23.
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var username: String = ""
    @State var contactNumber: String = ""
    @State var password: String = ""
    @State var reTypePassword: String = ""
    @State private(set) var profilePicture: String = "person.circle"
    
    var body: some View {
        NavigationView {
            ZStack{
                BackGroundView()
                
                VStack{
                    HStack{
                        Text("Sign Up")
                            .font(.largeTitle)
                            .bold()
                            .padding(.horizontal,40)
                        Spacer()
                    }
                    
                    Image(systemName: profilePicture)
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    Text("Enter Your Details")
                        .font(.title2)
                    
                    VStack(alignment: .leading, spacing: 20){
                        
                        TextFieldView(fieldData: $firstName, placeholderText: "First Name...")
                        
                        TextFieldView(fieldData: $lastName, placeholderText: "Last Name...")
                        
                        TextFieldView(fieldData: $username, placeholderText: "User Name...")
                        
                        TextFieldView(fieldData: $contactNumber, placeholderText: "Phone Number...")
                        
                        SecureFieldView(fieldData: $password, placeholderText: "Password...")
                        
                        SecureFieldView(fieldData: $reTypePassword, placeholderText: "Re - Type Your Password...")
                        
                        NavigationLink {
                            ContentView()
                        } label: {
                            Text("Create account")
                                .font(.title2)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 300, height: 50)
                                .background(.black)
                                .cornerRadius(30)
                        }
                    }
                    .frame(width: 350, height: 475)
                    .background(.opacity(0.3))
                    .cornerRadius(20)
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

struct TextFieldView: View {
    
    @Binding var fieldData: String
    var placeholderText: String
    
    var body: some View {
        VStack(spacing: -5){
            TextField(text: $fieldData) {
                Text(placeholderText)
                    .font(.title3)
                    .foregroundColor(.black)
                    .bold()
            }
            .frame(width: 300, height: 50)
            
            Rectangle()
                .frame(width: 300, height: 1)
        }
    }
}

struct SecureFieldView: View {
    
    @Binding var fieldData: String
    var placeholderText: String
    
    var body: some View {
        VStack(spacing: -5){
            SecureField(text: $fieldData) {
                Text(placeholderText)
                    .font(.title3)
                    .foregroundColor(.black)
                    .bold()
            }
            .frame(width: 300, height: 50)
            
            Rectangle()
                .frame(width: 300, height: 1)
        }
    }
}
