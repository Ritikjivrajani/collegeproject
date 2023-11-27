//
//  PrivacyModel.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 27/11/23.
//

import Foundation
import SwiftUI

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
