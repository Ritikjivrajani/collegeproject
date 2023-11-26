//
//  mainMsgView.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 17/11/23.
//

import SwiftUI
import Contacts

struct mainMsgView: View {
    
    @State private var searchText = ""
    @State private var isImagePickerPresented = false
    @State private var items: [String] = ["user 1", "user 2", "user 3", "user 4", "user 5", "user 6", "user 7", "user 8"]
    
    var body: some View {
        NavigationView {
            
            VStack{
                ScrollView {
                    ForEach(items , id: \.self) { item in
                        VStack {
                            HStack (spacing: 16) {
                                NavigationLink {
                                    
                                } label: {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 32))
                                        .padding()
                                        .overlay(RoundedRectangle(cornerRadius: 44).stroke(Color.black , lineWidth: 1))
                                    VStack(alignment: .leading) {
                                        Text(item)
                                        Text("Message sent to user ")
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
                            mainMsgView()
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
                            Settings()
                        } label: {
                            VStack(alignment: .center){
                                Image(systemName: "person.2.badge.gearshape.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
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
                        
                        
                        Button {
                            Task.init {
                                await fetchData()
                            }
                        } label: {
                            Image(systemName: "square.and.pencil")
                        }

                    }
            })
        }
    }
    
    func fetchData() async {
        let store = CNContactStore()
        
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        
        do{
            try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, result in
                for number in contact.phoneNumbers{
                    
                    switch number.label{
                    case CNLabelPhoneNumberMobile:
                        print("- mobile: \(number.value.stringValue)")
                    case CNLabelPhoneNumberMain:
                        print("- Main: \(number.value.stringValue)")
                    default:
                        print("- Others: \(number.value.stringValue)")
                    }
                    
                    print("- \(number)")
                }
            })
        } catch {
            print(error)
        }
    }
}


struct mainMsgView_Previews: PreviewProvider {
    static var previews: some View {
        mainMsgView()
    }
}
