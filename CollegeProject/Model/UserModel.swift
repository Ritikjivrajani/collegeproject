import Foundation

struct Description: Codable {
    let firstName: String
    let lastName: String
    let userName: String
    let email: String
    let contact: String
    let image: String
    let password: String
}

class SignInModel: ObservableObject {
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

struct LoginModel {
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

class login{
    func handleLogin(userName: String, password: String) {
        // Fetch data from the API
        LoginModel.fetchData { result in
            switch result {
            case .success(let users):
                // Compare user input with fetched user data
                if let matchedUser = users.first(where: { $0.userName == userName && $0.password == password }) {
                    // Login successful
                    print("Login successful for user: \(matchedUser.userName)")
                    //                   loginSuccess = true
                    return
                } else {
                    // Login failed
                    print("Invalid credentials")
                    //                   loginSuccess = false
                    return
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}
