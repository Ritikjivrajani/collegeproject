import Foundation
import Contacts
import ContactsUI

struct Description: Codable {
    let firstName: String
    let lastName: String
    let userName: String
    let email: String
    let contact: String
    let image: String
    let password: String
}

class API {
    func getAPI() {
        guard let url = URL(string: "https://flashchatcollageproject.000webhostapp.com/Fetch_API.php") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            do {
                let decodedData = try JSONDecoder().decode([Description].self, from: data!)
                print(decodedData)
                // Process the decoded data here
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
}

class YourViewModel: ObservableObject {
    @Published var yourData: Description?

    func insertData(firstName: String, lastName: String, userName: String, contact: String, email: String, image: String, password: String) {
        guard let url = URL(string: "https://flashchatcollageproject.000webhostapp.com/Insert_API.php") else { return }
        let parameters: [String: Any] = [
            "firstname": firstName,
            "lastname": lastName,
            "username": userName,
            "email": email,
            "contact": contact,
            "image": image,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Use "GET", "POST", or any other HTTP method
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)

        // Set up your request body if needed
        // request.httpBody = ...

        URLSession.shared.dataTask(with: request) { data, response, error in
                // Parse the data and update yourData property
                if let data = data {
                    let decoder = JSONDecoder()
                    if let decodedData = try? decoder.decode(Description.self, from: data) {
                        DispatchQueue.main.async {
                            self.yourData = decodedData
                        }
                    }
                }
            
        }.resume()
    }
}


//// Define a structure to match the JSON response
//struct APIResponse: Codable {
//    let userName: String
//    let password: String
//}
//
//struct APIService {
//    static func fetchData(completion: @escaping (Result<[String], Error>) -> Void) {
//        guard let url = URL(string: "https://flashchatcollageproject.000webhostapp.com/Fetch_API.php") else {
//            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                completion(.failure(NSError(domain: "Server Error", code: 0, userInfo: nil)))
//                return
//            }
//            
//            do {
//                if let data = data {
//                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
//                    completion(apiResponse.userName)
////                    completion(.success(apiResponse.userName))
//                } else {
//                    completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
//                }
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//    
//    static func compareData(with userInput: String, completion: @escaping (Result<Bool, Error>) -> Void) {
//        fetchData { result in
//            switch result {
//            case .success(let fetchedStrings):
//                // Compare userInput with fetchedStrings
//                let isMatch = fetchedStrings.contains(userInput)
//                completion(.success(isMatch))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//}
//
//// Usage example:
//let userInput = "UserInputHere" // Replace this with the user's input
//APIService.compareData(with: userInput) { result in
//    switch result {
//    case .success(let isMatch):
//        if isMatch {
//            print("User input matches data fetched from the API")
//        } else {
//            print("User input doesn't match data fetched from the API")
//        }
//    case .failure(let error):
//        print("Error comparing data: \(error)")
//        // Handle the error
//    }
//}


struct User: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let userName: String
    let email: String
    let contact: String
    let image: String
    let password: String
    // Add other properties as needed to match the JSON structure
}

struct APIService {
    static func fetchData(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://flashchatcollageproject.000webhostapp.com/Fetch_API.php") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Server Error", code: 0, userInfo: nil)))
                return
            }
            
            do {
                if let data = data {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(users))
                } else {
                    completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
