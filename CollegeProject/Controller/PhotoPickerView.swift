//
//  PhotoPickerView.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 27/11/23.
//

import SwiftUI
import UIKit
import PhotosUI


struct PhotoPickerView: UIViewControllerRepresentable {
    
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
