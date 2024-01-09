//
//  ProfileViewModel.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 26/11/23.
//

import Foundation
import SwiftUI

//class ProfileViewModel: ObservableObject {
//    @Published var name: String = "John Doe"
//    @Published var phoneNumber: String = "123-456-7890"
//    @Published var about: String = "About me..."
//    @Published var profilePicture: UIImage
//
//    init() {
//        // Provide a default image if "default-profile-picture" is not found
//        if let defaultImage = UIImage(systemName: "person.circle"){
//            self.profilePicture = defaultImage
//        } else {
//            // You can replace this with your own default image
//            self.profilePicture = UIImage(systemName: "person.circle")!
//        }
//    }
//
//    func saveProfile() {
//        // Save Your Image With This Function, More Code Come Soon...
//        print("Profile saved")
//    }
//}

class ProfileViewModel: ObservableObject {
    @Published var profilePicture = UIImage(named: "defaultProfileImage")! // Set a default image
    @Published var name = ""
    @Published var lastname = ""
    @Published var phoneNumber = ""
    @Published var about = ""

    func fetchProfileData() {
            guard let url = URL(string: "https://flashchatcollageproject.000webhostapp.com/Fetch_API.php") else {
                return
            }

            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let userData = try decoder.decode(UserData.self, from: data)

                        DispatchQueue.main.async {
                            // Update ViewModel properties with fetched data
                            self.name = userData.firstname
                            self.phoneNumber = userData.contact
                            self.about = userData.email

                            // Load the image only if the imageUrl is provided
                            if let imageUrl = URL(string: userData.image) {
                                self.loadImage(from: imageUrl)
                            } else {
                                // Set a default image if imageUrl is not provided
                                self.profilePicture = UIImage(named: "defaultProfileImage")!
                            }
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching data: \(error)")
                }
            }.resume()
        }

    private func loadImage(from imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profilePicture = image
                }
            } else if let error = error {
                print("Error loading image: \(error)")
            }
        }.resume()
    }
}

struct Profilemodel: Codable {
    let firstname: String
    let lastname: String
    let contact: String
    let email: String
    let image: String
}

