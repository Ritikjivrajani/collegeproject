//
//  CollegeProjectApp.swift
//  CollegeProject
//
//  Created by karishma on 12/11/23.
//

import SwiftUI

@main
struct CollegeProjectApp: App {
    @State private var showLaunchView: Bool = true
    var body: some Scene {
        WindowGroup {
            ZStack{
                
                ZStack{
                    if showLaunchView{
                        LaunchScreen(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .bottom))
                    }
                }
                .zIndex(0.2)
            }
        }
    }
}
