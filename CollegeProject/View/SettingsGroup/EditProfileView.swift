//
//  EditProfileView.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 26/11/23.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @State private var isImagePickerPresented = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Picture")) {
                    Image(uiImage: viewModel.profilePicture)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .onTapGesture {
                            // Show image picker when profile picture is tapped
                            isImagePickerPresented = true
                        }

                    Button("Edit Picture") {
                        // Show image picker when "Edit Picture" is tapped
                        isImagePickerPresented = true
                    }
                    .foregroundColor(.blue)
                    .sheet(isPresented: $isImagePickerPresented) {
                        PhotoPickerView(image: $viewModel.profilePicture)
                    }
                }

                Section(header: Text("Profile Information")) {
                    TextField("Name", text: $viewModel.name)
                    TextField("Phone Number", text: $viewModel.phoneNumber)
                        .keyboardType(.phonePad)
                    TextEditor(text: $viewModel.about)
                        .frame(height: 100)
                }
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarItems(trailing: Button("Save") {
            // Implement logic to save changes
            viewModel.saveProfile()
        })
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
