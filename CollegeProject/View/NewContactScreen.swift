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
    
    @State private var searchText = ""
    @State var displayContact = ""
    @State private var contacts: [model] = []
    @State private var selectedConatct: [CNContact] = []
    @State var picker = ""
    
    var pickerData = ["user1", "user2", "user3", "user4", "user5"]
    
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
                            Picker("Pick Contacts", selection: $picker) {
                                ForEach(pickerData, id: \.self){ item in
                                        Text(item)
                                }
                            }
                            .pickerStyle(.navigationLink)
                    }
                }
                .navigationTitle("New Chats")
                .navigationBarTitleDisplayMode(.inline)
//                .onAppear(perform: fetchContacts)
            }
        }
    }
    
//    func fetchContacts() {
//        forContacts().fetchAllContacts { item in
//            // Assuming 'item' is of type Contact
//            contacts.append(item)
//        }
//    }
    
}

struct model: Hashable, Codable{
    var name: String
    var contact: String
}

class forContacts: ObservableObject{
    func fetchAllContacts(completion: @escaping(model) -> ()) {
        
        let store = CNContactStore()
        
        let keys = [CNContactGivenNameKey,CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        
        do{
            try store.enumerateContacts(with: fetchRequest) { contact, result in
                
                api().fetchConatct() { DBContact in
                    for number in contact.phoneNumbers{
                        switch number.label {
                        case CNLabelPhoneNumberMobile:
                            for dbcontact in DBContact.data{
                                if dbcontact == number.value.stringValue{
                                    completion(model(name: contact.givenName, contact: number.value.stringValue))
                                }
                            }
                            
                        case CNLabelPhoneNumberMain:
                            for dbcontact in DBContact.data{
                                if dbcontact == number.value.stringValue{
                                    completion(model(name: contact.givenName, contact: number.value.stringValue))
                                }
                            }
                            
                        default:
                            for dbcontact in DBContact.data{
                                if dbcontact == number.value.stringValue{
                                    completion(model(name: contact.givenName, contact: number.value.stringValue))
                                }
                            }
                        }
                    }
                }
            }
        } catch {
            print("error occured")
        }
    }
}

#Preview {
    NewContactScreen()
}
