
//
//  Settings.swift
//  CollegeProject
//
//  Created by karishma on 17/11/23.
//

import SwiftUI

struct Settings: View {
    var settingsItem: [String] = ["Accounts", "Privacy", "Contact Us", "Terms and Conditions"]
    
    var settingsItem2: [String] = ["Help", "Tell a Friend"]
    
    var body: some View {
        NavigationView {
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
                                NavigationLink{
                                    
                                } label: {
                                    Text(Item)
                                }
                            }
                        }
                        .listRowBackground(Color.gray .opacity(0.3))
                        
                        Section{
                            ForEach(settingsItem2, id: \.self){ Item in
                                NavigationLink{
                                    //
                                } label: {
                                    Text(Item)
                                }
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
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
