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
    @State var email: String = ""
    @StateObject private var profile = ProfileViewModel()
    @State private var isImagePickerPresented = false
    @State private var isSignedIn = false
    @ObservedObject var viewModel = SignInModel()
    
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
                    Image(uiImage: profile.profilePicture)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .onTapGesture {
                            isImagePickerPresented = true
                        }

                .sheet(isPresented: $isImagePickerPresented) {
                    PhotoPickerView(image: $profile.profilePicture)
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
                    
                        Button(action: { viewModel.insertData(firstName: firstName, lastName: lastName, userName: username, contact: contactNumber, email: email, image: "", password: password) }, label: {
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
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
