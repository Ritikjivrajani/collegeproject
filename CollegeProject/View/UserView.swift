//
//  mainMsgView.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 17/11/23.
//

import SwiftUI
import ContactsUI


struct mainMsgView: View {
    
    @State private var selectedContacts: [CNContact] = []
    @State private var isContactPickerPresented = false
    @State private var searchText = ""
    @State private var isImagePickerPresented = false
    
    var body: some View {
        NavigationView {
            
            VStack{
                ScrollView {
                    ForEach(selectedContacts , id: \.self) { contact in
                        VStack {
                            HStack (spacing: 16) {
                                NavigationLink {
                                    
                                } label: {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 32))
                                        .padding()
                                        .overlay(RoundedRectangle(cornerRadius: 44).stroke(Color.black , lineWidth: 1))
                                    VStack(alignment: .leading) {
                                        Text("\(contact.givenName) \(contact.familyName)")
                                        
                                    }
                                    Spacer()
                                    
                                    Text("22nd")
                                        .font(.system(size: 14 , weight: .semibold))
                                }
                                .foregroundColor(.black)

                            }
                            
                            Divider()
                            .padding(.vertical , 8)
                        }.padding(.horizontal)
                    }
                }
                
                VStack{
                    HStack{
                        
                        NavigationLink{
                            EditProfileView()
                        } label: {
                            VStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                                
                                Text("Profile")
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(width: 100)
                        
                        NavigationLink{
                            
                        } label: {
                            VStack(alignment: .center){
                                Image(systemName: "ellipsis.message.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                                
                                Text("Chats")
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(width: 100)
                        
                        NavigationLink{
                            Settings()
                        } label: {
                            VStack(alignment: .center){
                                Image(systemName: "person.2.badge.gearshape.fill")
                                    .resizable()
                                    .frame(width: 40, height: 30)
                                    .foregroundColor(.black)
                                
                                Text("settings")
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(width: 100)
                    }
                }
            }
            
            .navigationTitle("Chats")
            .searchable(text: $searchText)
            
            .toolbar(content:
                {
                    
                ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            
                        } label: {
                            Text("Edit").bold()
                        }
                    }
                    
                    
                    ToolbarItemGroup(placement: .primaryAction) {
                        Button(action:{
                            isImagePickerPresented.toggle()
                        }) {
                            Image(systemName: "camera")
                            
                        }
                        
                        .sheet(isPresented: $isImagePickerPresented) {
                            CameraView(isImagePickerPresented: $isImagePickerPresented)
                        }
                        .padding()
                        
                        Button{
                            // Present the contact picker
                            self.isContactPickerPresented.toggle()
                        } label: {
                            Image(systemName: "square.and.pencil")
                        }
                        .sheet(isPresented: $isContactPickerPresented) {
                                        ContactPicker(selectedContacts: $selectedContacts)
                                    }
                    }
            })
        }
    }
    
}


struct mainMsgView_Previews: PreviewProvider {
    static var previews: some View {
        mainMsgView()
    }
}
