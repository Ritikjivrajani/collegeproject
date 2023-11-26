//
//  LaunchScreen.swift
//  CollegeProject
//
//  Created by karishma on 13/11/23.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var loadingText: [String] = "FlashChat".map{ String($0) }
    @State private var showLoadingText: Bool = false
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack{
            Color(.white)
                .ignoresSafeArea()
            
                Image(systemName: "ellipsis.message.fill")
                    .resizable()
                    .frame(width: 150,height: 150)
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom,25)
                    .foregroundColor(Color("newColor"))
               
            ZStack{
                if showLoadingText {
                    HStack(spacing: 1){
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.largeTitle)
                                .foregroundColor(Color("newColor"))
                                .fontWeight(.heavy)
                                .offset(y: counter == index ? -15 : 0)
                                .padding(.top,50)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 100)
        }
        .onAppear{
            showLoadingText.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex{
                    counter = 0
                    loops += 1
                    if loops >= 2{
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        })
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen(showLaunchView: .constant(true))
    }
}
