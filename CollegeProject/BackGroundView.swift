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
                .frame(width: 400, height: 400)
                .offset(x: -200, y: -275)
                .foregroundColor(Color("newColor"))
            
            Circle()
                .frame(width: 400, height: 400)
                .offset(x: 200, y: -75)
                .foregroundColor(Color("newColor"))
        }
        
//        NavigationView{
//            ZStack{
//                Image("BackImage")
//                    .resizable()
//                    .ignoresSafeArea()
//            }
//        }
    }
}

struct BackGroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackGroundView()
    }
}
