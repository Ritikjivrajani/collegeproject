//
//  ContactView.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 26/11/23.

import SwiftUI
import ContactsUI

struct ContactPicker: UIViewControllerRepresentable {
    @Binding var selectedContacts: [CNContact]

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = context.coordinator
        contactPicker.predicateForSelectionOfContact = NSPredicate(value: true)
        contactPicker.predicateForSelectionOfProperty = NSPredicate(value: true)
        return contactPicker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {
        // Update the view controller if needed
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedContacts: $selectedContacts)
    }

    class Coordinator: NSObject, CNContactPickerDelegate {
        @Binding var selectedContacts: [CNContact]

        init(selectedContacts: Binding<[CNContact]>) {
            _selectedContacts = selectedContacts
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            // Check if the selected contact already exists in the array
            if !selectedContacts.contains(where: { $0.identifier == contact.identifier }) {
                // If the contact is not already in the array, add it
                selectedContacts.append(contact)
                
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        private func contactPicker(_ picker: CNContactPickerViewController, didDeselectContact contact: CNContact) {
            if let index = selectedContacts.firstIndex(of: contact) {
                selectedContacts.remove(at: index)
            }
        }

        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            // Handle cancellation
        }
    }
}
