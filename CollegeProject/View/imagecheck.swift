//
//  imagecheck.swift
//  CollegeProject
//
//  Created by karishma on 06/12/23.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var imageURL: URL?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let imageUrl = info[.imageURL] as? URL {
                parent.imageURL = imageUrl
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct imagecheck: View {
    @State private var selectedImageURL: URL?

    var body: some View {
        VStack {
            if let imageURL = selectedImageURL {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .onTapGesture {
                        // Show or perform actions with the selected image URL
                        print("New Selected Image URL: \(imageURL)")
                    }
            } else {
                Button("Select Image") {
                    // Show image picker when the button is tapped
                    isImagePickerShown.toggle()
                }
            }
        }
        .sheet(isPresented: $isImagePickerShown) {
            ImagePicker(imageURL: $selectedImageURL)
        }
    }

    @State private var isImagePickerShown = false
}


#Preview {
    imagecheck()
}
