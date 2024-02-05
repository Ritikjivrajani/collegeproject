//
//  LogInView.swift
//  CollegeProject
//
//  Created by karishma on 15/11/23.
//

import SwiftUI
import FirebaseAuth

struct LogInView: View {
    
    @State var userName: String = ""
    @State var password: String = ""
    @State private var profilePicture: String = "person.circle"
    @State private var showAlert = false
    @State private var loginSuccess = false
    var viewModel = login()
    @State var email = ""
    
    var body: some View {
        ZStack{
            BackGroundView()
            
            Group{
                VStack{
                    HStack{
                        Text("Log in")
                            .font(.largeTitle)
                            .bold()
                            .padding(.horizontal,40)
                            .padding(.bottom, 60)
                        Spacer()
                    }
                    
                    VStack{
                        Image(systemName: profilePicture)
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        Text("Enter Your Details")
                            .font(.title2)
                    }
                    .padding(.bottom, 100)
                    
                    Group{
                        VStack(alignment: .leading, spacing: 20){
                            TextFieldView(fieldData: $email, placeholderText: "Email...")
                            
                            SecureFieldView(fieldData: $password, placeholderText: "Password...")
                            
                            Button {
                                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                                    if let e = error{
                                        print(e)
                                    } else {
                                        print("Login success...")
                                    }
                                }
                            } label: {
                                Text("Log in")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .bold()
                                    .frame(width: 300, height: 50)
                                    .background(.black)
                                    .cornerRadius(30)
                            }
                            
                            
                        }
                        .frame(width: 350, height: 250)
                        .background(.opacity(0.3))
                        .cornerRadius(20)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
