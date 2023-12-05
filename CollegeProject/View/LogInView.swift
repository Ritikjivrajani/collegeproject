//
//  LogInView.swift
//  CollegeProject
//
//  Created by karishma on 15/11/23.
//

import SwiftUI

struct LogInView: View {
    
    @State var userName: String = ""
    @State var password: String = ""
    @State private var profilePicture: String = "person.circle"
    @State private var isAuthenticated = false
    
    @State private var loginSuccess = false
    
    func handleLogin() {
           // Fetch data from the API
           APIService.fetchData { result in
               switch result {
               case .success(let users):
                   // Compare user input with fetched user data
                   if let matchedUser = users.first(where: { $0.userName == userName && $0.password == password }) {
                       // Login successful
                       print("Login successful for user: \(matchedUser.userName)")
                       loginSuccess = true
                   } else {
                       // Login failed
                       print("Invalid credentials")
                       loginSuccess = false
                   }
               case .failure(let error):
                   print("Error fetching data: \(error)")
               }
           }
       }
    
//    let userInput = "UserInputHere" // Replace this with the user's input
    
    
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
                            TextFieldView(fieldData: $userName, placeholderText: "User Name...")
                            
                            SecureFieldView(fieldData: $password, placeholderText: "Password...")
                            
                                Button { handleLogin() } label: {
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
