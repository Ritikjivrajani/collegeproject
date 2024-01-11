//
//  LogInView.swift
//  CollegeProject
//
//  Created by karishma on 15/11/23.
//

import SwiftUI

struct LogInView: View {
    
    @ObservedObject var fetchData = FetchData()
    
    @State var success = false
    @State var failed = true
    @State var userName: String = ""
    @State var password: String = ""
    @State private var profilePicture: String = "person.circle"
    @State private var showAlert = false
    @State private var loginSuccess = false
    @State private var isLoggedIn = false
    @State var displayUser = ""
    @State var alerTitle = ""
    
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
                        
                        Text(alerTitle)
                        
                        Group{
                            VStack(alignment: .leading, spacing: 20){
                                TextFieldView(fieldData: $userName, placeholderText: "User Name...")
                                
                                SecureFieldView(fieldData: $password, placeholderText: "Password...")
                                
                                
                                Button {
                                    
                                    handleLogin()
                                    
                                } label: {
                                    Text("Log in")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .bold()
                                        .frame(width: 300, height: 50)
                                        .background(.black)
                                        .cornerRadius(30)
                                }
                                
                                
                                
                                NavigationLink(
                                    destination: UserView(), // Navigate to HomeView when isLoggedIn is true
                                    isActive: $isLoggedIn,
                                    label: { EmptyView() }
                                ).hidden()
                                
                            }
                            .frame(width: 350, height: 250)
                            .background(.opacity(0.3))
                            .cornerRadius(20)
                            .padding(.bottom, 30)
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        getAlert()
                    }
                }
            
        }
    }
    
    func getAlert() -> Alert{
        return Alert(title: Text(alerTitle))
    }
    
    func textIsAppropriate(textBoxValue: String){
        if textBoxValue != ""{
            alerTitle = "please fill the blanks!!!"
        }
        else{
            if failed == true{
                alerTitle = "Invalid UserName and Password!!!"
            }
        }
    }
    
    struct forHandleLogin{
        var isSuccess: Bool
        var isFailed: Bool
        var matchedUser: String
        var image: String
    }
    
    func handleLogin() {
        // Fetch data from the API
        FetchDataModel.fetchData { result in
            switch result {
            case .success(let users):
                // Compare user input with fetched user data
                if let matchedUser = users.first(where: { $0.username == userName && $0.password == password }) {
                    // Login successful
                    print("Login successful for user: \(matchedUser.username)")
                    isLoggedIn = true
                } else {
                    // Login failed
                    print("Invalid credentials")
                    isLoggedIn = false
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
