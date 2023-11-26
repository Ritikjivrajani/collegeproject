//
//  EditProfileView.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 26/11/23.
//

import SwiftUI
import UIKit
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
                        PhotoPicker(image: $viewModel.profilePicture)
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
            .navigationTitle("Edit Profile")
            .navigationBarItems(trailing: Button("Save") {
                // Implement logic to save changes
                viewModel.saveProfile()
            })
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
//mark: - this is test
struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        @Binding var image: UIImage

        init(image: Binding<UIImage>) {
            _image = image
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { (loadedImage, error) in
                    if let loadedImage = loadedImage as? UIImage {
                        DispatchQueue.main.async {
                            self.image = loadedImage
                        }
                    }
                }
            }

            picker.dismiss(animated: true, completion: nil)
        }

        func pickerDidCancel(_ picker: PHPickerViewController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
}

class ProfileViewModel: ObservableObject {
    @Published var name: String = "John Doe"
    @Published var phoneNumber: String = "123-456-7890"
    @Published var about: String = "About me..."
    @Published var profilePicture: UIImage

    init() {
        // Provide a default image if "default-profile-picture" is not found
        if let defaultImage = UIImage(named: "default-profile-picture") {
            self.profilePicture = defaultImage
        } else {
            // You can replace this with your own default image
            self.profilePicture = UIImage(systemName: "person.fill")!
        }
    }

    func saveProfile() {
        // Implement logic to save changes to the backend or storage
        print("Profile saved")
    }
}

