//
//  NewContactScreen.swift
//  CollegeProject
//
//  Created by karishma on 11/12/23.
//

import SwiftUI
import Contacts
import ContactsUI

struct NewContactScreen: View {
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

    @State private var searchText = ""
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    Section{
                        NavigationLink{
                            
                        } label: {
                            Text("New Group")
                                .foregroundStyle(.blue)
                                .font(.title3)
                        }
                    }
                    
                    Section{
                        ForEach(1...10, id: \.self){ contact in
                            HStack{
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading){
                                    Text("contact \(contact)")
                                        .font(.system(size: 20))
                                        .fontWeight(.heavy)
                                    Text("caption")
                                        .foregroundStyle(.gray)
                                        .font(.headline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("New Chats")
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar{
//                ToolbarItem{
//                    Button("✖️"){
//                        
//                    }
//                }
//            }
        }
    }
}

#Preview {
    NewContactScreen()
}
