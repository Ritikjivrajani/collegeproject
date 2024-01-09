import Foundation
import Contacts

struct Description: Codable {
    let firstname: String
    let lastname: String
    let username: String
    let email: String
    let contact: String
    let image: String
    let password: String
}

//MARK: - ForInsertData

class InsertDataModel: ObservableObject {
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
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
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

//MARK: - For FetchData

struct FetchDataModel {
    static func fetchData(completion: @escaping (Result<[Description], Error>) -> Void) {
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
                    let users = try JSONDecoder().decode([Description].self, from: data)
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



//struct ContactDescription: Codable{
//    let name: String
//    let contact: String
//}

//class ContactAPI{
//    func sendContactsToAPI(Name: String, Contact: String) {
//        // Contacts data to be sent
//        let contactsData: [String: Any] = [
//            "contacts": [
//                ["name": Name, "phone_number": Contact]
//                // Add more contacts as needed
//            ]
//        ]
//
//        // Convert the contacts data to JSON
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: contactsData) else {
//            return
//        }
//
//        // API endpoint URL
//        let apiURL = URL(string: "https://flashchatcollageproject.000webhostapp.com/access_phonebook_API.php")!
//        
//        var request = URLRequest(url: apiURL)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                // Handle error
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                print("Invalid response")
//                // Handle invalid response
//                return
//            }
//            
//            if let data = data {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print("Response: \(json)")
//                    // Handle the response from the API
//                } catch {
//                    print("Error parsing JSON: \(error.localizedDescription)")
//                    // Handle JSON parsing error
//                }
//            }
//        }.resume()
//    }
//}
//

struct contactFetch: Decodable{
    let data: [String]
}

class api{
    func fetchConatct(completion: @escaping (contactFetch) -> ()){
        guard let url = URL(string: "https://flashchatcollageproject.000webhostapp.com/select_contact_API.php") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            let decodedData = try! JSONDecoder().decode(contactFetch.self, from: data!)
            completion(decodedData)
        }.resume()
    }
}

struct UserData: Codable {
    let id: String
    let firstname: String
    let lastname: String
    let username: String
    let email: String
    let contact: String
    let image: String
    let password: String
}

class FetchData: ObservableObject {
    @Published var userData = [UserData]()
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://flashchatcollageproject.000webhostapp.com/Fetch_API.php") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([UserData].self, from: data)
                DispatchQueue.main.async {
                    self.userData = decodedData
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}


