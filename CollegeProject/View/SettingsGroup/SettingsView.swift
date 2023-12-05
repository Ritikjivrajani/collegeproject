//
//  Settings.swift
//  CollegeProject
//
//  Created by karishma on 17/11/23.
//

import SwiftUI

struct SettingsView: View {
    
    var settingsItem: [String] = ["Accounts", "Privacy", "Contact Us", "Terms and Conditions"]
    var settingsItem2: [String] = ["Help", "Tell a Friend"]
    
    var body: some View {
            ZStack{
                VStack{
                    HStack{
                        Text("Settings")
                            .font(.largeTitle)
                            .bold()
                            .padding(.horizontal,40)
                        Spacer()
                    }
                    .offset(y: -30)
                    
                    List{
                        Section{
                            ForEach(settingsItem, id: \.self){ Item in
                                itemView(for: Item)
                            }
                        }
                        .listRowBackground(Color.gray .opacity(0.3))
                        
                        Section{
                            ForEach(settingsItem2, id: \.self){ Item in
                                itemView(for: Item)
                            }
                        }
                        .listRowBackground(Color.gray .opacity(0.3))
                    }
                    .offset(y: -30)
                }
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                .background{
                    BackGroundView()
                }
            }
    }
    
    @ViewBuilder
    func itemView(for item: String) -> some View {
        switch item {
        case "Accounts":
            NavigationLink(destination: EditProfileView()) {
                Text("Accounts")
            }
        case "Privacy":
            NavigationLink(destination: Privacy()) {
                Text("Privacy")
            }
        case "Terms and Conditions":
            NavigationLink(destination: TermsAndConditions()) {
                Text("Terms and conditions")
            }
        case "Contact Us":
            NavigationLink(destination: ContactUs()) {
                Text("Contact Us")
            }
        case "Help":
            NavigationLink(destination: Help()) {
                Text("Help")
            }
        default:
            NavigationLink(destination: TellAFriend()) {
                Text("Tell a Friend")
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
