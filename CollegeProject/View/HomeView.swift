//
//  HomeView.swift
//  CollegeProject
//
//  Created by karishma on 12/11/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            ZStack{
                BackGroundView()
                VStack{
                    Group{
                        VStack(alignment: .leading){
                            Text("Welcome to")
                                .font(.title2)
                            
                            Text("Flash chat")
                                .font(.largeTitle)
                                .bold()
                        }
                        .offset(x: -70, y: -30)
                        .padding(.bottom, 100)
                    }
                    
                    Group{
                        VStack(spacing: 20){
                            
                            NavigationLink(destination: SignUpView(), label: {
                                Text("Sign Up")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: 300, height: 50)
                                    .background(.black)
                                    .cornerRadius(30)
                            })
                            
                            NavigationLink(destination: LogInView(), label: {
                                Text("Log In")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: 300, height: 50)
                                    .background(.black)
                                    .cornerRadius(30)
                            })
                            
                        }
                        .frame(width: 325, height: 200)
                        .background(.opacity(0.3))
                        .cornerRadius(20)
                        .offset(y: 80)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



