//
//  CollegeProjectApp.swift
//  CollegeProject
//
//  Created by karishma on 12/11/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct CollegeProjectApp: App {
    @State private var showLaunchView: Bool = true
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ZStack{
                HomeView()
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
