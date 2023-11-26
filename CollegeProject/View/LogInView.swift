//
//  LogInView.swift
//  CollegeProject
//
//  Created by karishma on 16/11/23.
//

import SwiftUI

struct LogInView: View {
    @State var userName: String = ""
    @State var password: String = ""
    @State private var profilePicture: String = "person.circle"
    var body: some View {
        NavigationView {
            ZStack{
                BackGroundView()
                
                VStack{
                    HStack{
                        Text("Log in")
                            .font(.largeTitle)
                            .bold()
                            .padding(.horizontal,40)
                        Spacer()
                    }
                    
                    VStack{
                        Image(systemName: profilePicture)
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        Text("Enter Your Details")
                            .font(.title2)
                    }
                    .padding(.bottom, 170)
                    
                    VStack(alignment: .leading, spacing: 20){
                        TextFieldView(fieldData: $userName, placeholderText: "User Name...")
                        
                        SecureFieldView(fieldData: $password, placeholderText: "Password...")
                        
                        NavigationLink {
                            mainMsgView()
                        } label: {
                            Text("Log in")
                                .font(.title2)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 300, height: 50)
                                .background(.black)
                                .cornerRadius(30)
                        }
                    }
                    .frame(width: 350, height: 250)
                    .background(.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.bottom, 75)
                }
            
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
