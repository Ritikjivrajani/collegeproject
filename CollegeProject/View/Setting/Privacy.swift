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
