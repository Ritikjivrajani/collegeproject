//
//  SignInView.swift
//  CollegeProject
//
//  Created by karishma on 13/11/23.
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    
    func sendDataToServer() {
            guard let url = URL(string: "https://flashchatcollageproject.000webhostapp.com/Insert_API.php") else {
                print("Invalid URL")
                return
            }

            let parameters = [
                "firstName": firstName,
                "lastName": lastName,
                "userName": username,
                "contact": contactNumber,
                "email": email,
                "image": tempImage,
                "password": password
            ]

            guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
                print("Failed to serialize data")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }

                if let data = data {
                    // Process the response data here
                    // Example: parse JSON response if the server returns JSON data
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Response: \(responseString)")
                        // Handle the response accordingly in your app
                    }
                }
            }.resume()
        }
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var username: String = ""
    @State var contactNumber: String = ""
    @State var password: String = ""
    @State var reTypePassword: String = ""
    @State var email: String = ""
    @StateObject private var viewModel = ProfileViewModel()
    @State private var isImagePickerPresented = false
    @State var tempImage = "person.circle"
    
    var body: some View {
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
                
//                    Image(uiImage: viewModel.profilePicture)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 100, height: 100)
//                        .clipShape(Circle())
//                        .onTapGesture {
//                            isImagePickerPresented = true
//                        }
//
//                .sheet(isPresented: $isImagePickerPresented) {
//                    PhotoPickerView(image: $viewModel.profilePicture)
//                }
                
                TextFieldView(fieldData: $tempImage, placeholderText: "Enter Image...")
                
                Text("Enter Your Details")
                    .font(.title2)
                
                VStack(alignment: .leading, spacing: 20){
                    
                    TextFieldView(fieldData: $firstName, placeholderText: "First Name...")
                    
                    TextFieldView(fieldData: $lastName, placeholderText: "Last Name...")
                    
                    TextFieldView(fieldData: $username, placeholderText: "User Name...")
                    
                    TextFieldView(fieldData: $email, placeholderText: "Email Address...")
                    
                    TextFieldView(fieldData: $contactNumber, placeholderText: "Phone Number...")
                    
                    SecureFieldView(fieldData: $password, placeholderText: "Password...")
                    
                    SecureFieldView(fieldData: $reTypePassword, placeholderText: "Re - Type Your Password...")
                    
                    Button("send"){
                        sendDataToServer()
                    }
                    
                    
                    NavigationLink(destination: mainMsgView(), label: {
                        Text("Create account")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 300, height: 50)
                            .background(.black)
                            .cornerRadius(30)
                    })
                }
                .frame(width: 350, height: 550)
                .background(.opacity(0.3))
                .cornerRadius(20)
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
