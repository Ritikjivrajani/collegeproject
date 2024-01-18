//
//  mainMsgView.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 16/11/23.
//

import SwiftUI
import ContactsUI
import Contacts

struct ContactNumbersResponse: Codable {
    let success: Bool
    let message: String
    let data: [String]
}

struct UserView: View {
    @State private var userContactNumbers: [String] = []
    @State private var apiContactNumbers: [String] = []
    @State private var selectedContacts: [CNContact] = []
    @State private var isContactPickerPresented = false
    @State private var searchText = ""
    @State private var isImagePickerPresented = false
    @State private var selectContact = false
    @State private var fetchedContactNumbers: [String] = []

    @ObservedObject var viewModel = InsertDataModel()
    @State private var scrollToTop = false

    var body: some View {
        NavigationView {
            VStack {
                //MARK: - UserDisplayView()
                    List {
                        ForEach(selectedContacts, id: \.self) { contact in
                            HStack(spacing: 16) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 32))
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 44).stroke(Color.black , lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text("\(contact.givenName) \(contact.familyName)")
                                    
                                    Text(contact.phoneNumbers.first?.value.stringValue ?? "")
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text("22nd")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .foregroundColor(.black)
                            .onTapGesture {
                                // Handle tapping on the contact
                                InsertDataModel().insertData(firstName: contact.givenName, lastName: contact.familyName, userName: "\(contact.givenName) \(contact.familyName)", contact: contact.phoneNumbers.first?.value.stringValue ?? "", email: "\(contact.givenName)@gmail.com", image: "123", password: "123456")
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(.grouped)
                    .scrollContentBackground(.hidden)
                

                //MARK: - BottomView()
                VStack {
                    HStack {
                        NavigationLink(destination: EditProfileView(), label: {
                            VStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                                
                                Text("Profile")
                                    .foregroundColor(.black)
                            }
                        })
                        .frame(width: 100)
                        
                        Button(action: {
                            scrollToTop = true
                        }) {
                            VStack(alignment: .center) {
                                Image(systemName: "ellipsis.message.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                                
                                Text("Chats")
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(width: 100)
                        
                        NavigationLink(destination: Settings(), label: {
                            VStack(alignment: .center) {
                                Image(systemName: "person.2.badge.gearshape.fill")
                                    .resizable()
                                    .frame(width: 40, height: 30)
                                    .foregroundColor(.black)
                                
                                Text("Settings")
                                    .foregroundColor(.black)
                            }
                        })
                        .frame(width: 100)
                    }
                }
            }

            //MARK: -  navigationView()
            .navigationTitle("Chats")
            .searchable(text: $searchText)

            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button(action:{
                        isImagePickerPresented.toggle()
                    }) {
                        Image(systemName: "camera")
                        
                    }
                    .sheet(isPresented: $isImagePickerPresented) {
                        CameraView(isImagePickerPresented: $isImagePickerPresented)
                    }
                    .padding()
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    func deleteItems(indexSet: IndexSet) {
        selectedContacts.remove(atOffsets: indexSet)
    }
}

struct UserView_Preview: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
