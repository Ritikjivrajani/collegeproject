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
                        ForEach(contacts, id: \.self){ contact in
                            HStack{
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading){
                                    Text("\(contact.name)")
                                        .font(.system(size: 20))
                                        .fontWeight(.heavy)
                                    Text("caption")
                                        .foregroundStyle(.gray)
                                        .font(.headline)
                                }
                            }
                            .navigationTitle("New Chats")
                            .navigationBarTitleDisplayMode(.inline)
                            .onAppear(perform: fetchContacts)
                        }
                    }
                }
            }
        }
    }     
    func fetchContacts() {
        forContacts().fetchAllContacts { item in
            contacts.append(item)
        }
    }
}

struct model: Codable, Hashable{
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
