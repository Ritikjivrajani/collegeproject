//
//  BackGroundView.swift
//  CollegeProject
//
//  Created by karishma on 16/11/23.
//

import SwiftUI

struct BackGroundView: View {
    var body: some View {
        LazyVStack{
            Circle()
                .blur(radius: 2.0)
                .frame(width: 400, height: 400)
                .offset(x: -200, y: -275)
                .foregroundColor(Color("newColor"))
                .shadow(color: .black, radius: 40)
                .overlay {
                    Rectangle()
                        .frame(width: 15000, height: 800)
                        .foregroundStyle(Color.gray)
                        .opacity(0.5)
                        .rotationEffect(.degrees(-45))
                        .offset(y: -750)
                }
            
            Circle()
                .blur(radius: 2.0)
                .shadow(color: .black, radius: 40)
                .frame(width: 400, height: 400)
                .offset(x: 200, y: -75)
                .foregroundColor(Color("newColor"))
                .overlay {
                    Rectangle()
                        .frame(width: 15000, height: 800)
                        .foregroundStyle(Color.gray)
                        .opacity(0.5)
                        .rotationEffect(.degrees(-45))
                        .offset(y: 400)
                }
        }
    }
}

struct secondView: View {
    var body: some View{
        VStack{
            Rectangle()
                .frame(width: 1500, height: 500)
                .foregroundStyle(Color("newColor"))
                .offset(y: 200)
                .rotationEffect(.degrees(-45))
        }
    }
}

struct BackGroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackGroundView()
        secondView()
    }
}

