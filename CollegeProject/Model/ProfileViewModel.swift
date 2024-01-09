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
        if let defaultImage = UIImage(systemName: "person.circle"){
            self.profilePicture = defaultImage
        } else {
            self.profilePicture = UIImage(systemName: "person.circle")!
        }
    }

    func saveProfile() {
        //To save your profile more code come soon...
        print("Profile saved")
    }
}

