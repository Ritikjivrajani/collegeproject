//
//  Privacy.swift
//  CollegeProject
//
//  Created by karishma on 24/11/23.
//

import SwiftUI

struct Privacy: View {
    var body: some View {
        NavigationView {
            ZStack {
                BackGroundView()
                
                VStack(alignment: .leading, spacing: 20) {
                    NavigationLink(destination: LastSeenOnlineView()) {
                        Text("Last Seen & Online")
                    }

                    NavigationLink(destination: ProfilePhotoView()) {
                        Text("Profile Photo")
                    }

                    NavigationLink(destination: AboutView()) {
                        Text("About")
                    }

                    NavigationLink(destination: BlockedView()) {
                        Text("Blocked")
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Privacy")
        }
    }
}

struct LastSeenOnlineView: View {
    var body: some View {
        Text("Last Seen & Online View")
            .navigationTitle("Last Seen & Online")
    }
}

struct ProfilePhotoView: View {
    var body: some View {
        Text("Profile Photo View")
            .navigationTitle("Profile Photo")
    }
}

struct AboutView: View {
    var body: some View {
        Text("About View")
            .navigationTitle("About")
    }
}

struct BlockedView: View {
    var body: some View {
        Text("Blocked View")
            .navigationTitle("Blocked")
    }
}

struct Privacy_Previews: PreviewProvider {
    static var previews: some View {
        Privacy()
    }
}

