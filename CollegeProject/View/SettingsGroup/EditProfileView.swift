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
    @State private var selectedImage: UIImage?
    @State private var imagePath: String = "Image path will be displayed here"
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Picture")) {
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        
                        Button("Edit Picture") {
                            isImagePickerPresented = true
                        }
                        
                    } else {
                        Image(uiImage: viewModel.profilePicture)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .onTapGesture {
                                isImagePickerPresented = true
                            }
                        
                        Button("Edit Picture") {
                            isImagePickerPresented = true
                        }
                        .foregroundColor(.blue)
                        .sheet(isPresented: $isImagePickerPresented) {
                            PhotoPickerView(selectedImage: self.$selectedImage, imagePath: self.$imagePath)
                        }
                    }
                    
                    Button("Print url"){
                        print("URL IS.....\(imagePath)")
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
        .onAppear {
        }
        .navigationTitle("Edit Profile")
        .navigationBarItems(trailing: Button("Save") {
            
        })
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
