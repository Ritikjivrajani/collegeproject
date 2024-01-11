//
//  NewImageCheck.swift
//  CollegeProject
//
//  Created by karishma on 11/01/24.
//

import SwiftUI
import PhotosUI

struct NewImageCheck: View {
    @State private var selectedImage: UIImage?
    @State private var imagePath: String = "Image path will be displayed here"
    @State private var isImagePickerPresented = false
    
    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
            } else {
                Text("No image selected")
            }
            
            Button("print"){
                print(imagePath)
            }
            
            Button("Select Image") {
                self.isImagePickerPresented.toggle()
            }
            .sheet(isPresented: $isImagePickerPresented) {
                PhotoPicker(selectedImage: self.$selectedImage, imagePath: self.$imagePath)
            }
        }
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var imagePath: String
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self.parent.selectedImage = image
                            self.parent.saveImageToDocumentsDirectory(image: image)
                        }
                    }
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // Update the view controller if needed
    }
    
    func saveImageToDocumentsDirectory(image: UIImage) {
        if let data = image.jpegData(compressionQuality: 1.0) {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let filename = "selectedImage.jpg"
            let imageUrl = documentsDirectory.appendingPathComponent(filename)
            
            do {
                try data.write(to: imageUrl)
                self.imagePath = imageUrl.path
            } catch {
                print("Error writing image to documents directory: \(error)")
                self.imagePath = "Image path not found"
            }
        }
    }
}

#Preview{
    NewImageCheck()
}
