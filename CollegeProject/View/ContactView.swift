//
//  ContactView.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 26/11/23.
//


import SwiftUI
import ContactsUI


struct ContactView: View {
    

    var body: some View {
        VStack {
            Text("Selected Contact:")
        }
    }
}

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

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
            selectedContacts.append(contentsOf: contacts)
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

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
