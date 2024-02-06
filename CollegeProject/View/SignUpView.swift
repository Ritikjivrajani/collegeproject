//
//  SignInView.swift
//  CollegeProject
//
//  Created by karishma on 13/11/23.
//

import SwiftUI
import PhotosUI
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct SignUpView: View {
    
    @State private var isImagePickerPresented = false
    @ObservedObject private var profile = ProfileViewModel()
    @ObservedObject var viewModel = register()
    
    var body: some View {
        ZStack {
            BackGroundView()
            
            VStack(spacing: 30){
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
                    .sheet(isPresented: $isImagePickerPresented) { PhotoPickerView(image: $profile.profilePicture) }
                
                Text("Enter Your Details")
                    .font(.title2)
                
                VStack(alignment: .leading, spacing: 20){
                    
                    TextFieldView(fieldData: $viewModel.firstName, placeholderText: "First Name...")
                    
                    TextFieldView(fieldData: $viewModel.lastName, placeholderText: "Last Name...")
                    
                    TextFieldView(fieldData: $viewModel.contactNumber, placeholderText: "Phone Number...")
                    
                    TextFieldView(fieldData: $viewModel.email, placeholderText: "Email Address...")
                    
                    SecureFieldView(fieldData: $viewModel.password, placeholderText: "Password...")
                    
                    Button(action: {
                        viewModel.registerUser()
                    }, label: {
                        Text("Create account")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 300, height: 50)
                            .background(.black)
                            .cornerRadius(30)
                    })
                    
                    NavigationLink(
                        destination: LogInView(),
                        isActive: $viewModel.registerSuccess,
                        label: { EmptyView() }
                    ).hidden()
                }
                .frame(width: 350, height: 425)
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
