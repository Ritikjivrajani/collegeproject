//
//  ProfileViewModel.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 26/11/23.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var name: String = "John Doe"
    @Published var phoneNumber: String = "123-456-7890"
    @Published var about: String = "About me..."
    @Published var profilePicture: UIImage

    init() {
        // Provide a default image if "default-profile-picture" is not found
        if let defaultImage = UIImage(systemName: "person.circle"){
            self.profilePicture = defaultImage
        } else {
            // You can replace this with your own default image
            self.profilePicture = UIImage(systemName: "person.circle")!
        }
    }

    func saveProfile() {
        // Save Your Image With This Function, More Code Come Soon...
        print("Profile saved")
    }
}
