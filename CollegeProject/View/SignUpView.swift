//
//  SignInView.swift
//  CollegeProject
//
//  Created by karishma on 13/11/23.
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    
    // TextField properties
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var username: String = ""
    @State var contactNumber: String = ""
    @State var password: String = ""
    @State var reTypePassword: String = ""
    @State var email: String = ""
    
    // Another properties
    @State private var isImagePickerPresented = false
    @State private var isSignedIn = false
    @ObservedObject var viewModel = InsertDataModel()
    @State private var selectedImage: UIImage?
    @State private var imagePath: String = "Image path will be displayed here"
    @StateObject private var imageModel = ProfileViewModel()
    
    var body: some View {
        ScrollView{
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
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        
                    } else {
                        Image(uiImage: imageModel.profilePicture)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .onTapGesture {
                                isImagePickerPresented = true
                            }
                        
                            .foregroundColor(.blue)
                            .sheet(isPresented: $isImagePickerPresented) {
                                PhotoPickerView(selectedImage: self.$selectedImage, imagePath: self.$imagePath)
                            }
                    }
                    
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
                        
                        Button(action: { viewModel.insertData(firstName: firstName, lastName: lastName, userName: username, contact: contactNumber, email: email, image: imagePath, password: password)
                            
                            print("Registered successfully...")}, label: {
                                Text("Create account")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .bold()
                                    .frame(width: 300, height: 50)
                                    .background(.black)
                                    .cornerRadius(30)
                            })
                        NavigationLink(
                            destination: UserView(),
                            isActive: $isSignedIn,
                            label: { EmptyView() }
                        ).hidden()
                    }
                    .frame(width: 350, height: 550)
                    .background(.opacity(0.3))
                    .cornerRadius(20)
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

