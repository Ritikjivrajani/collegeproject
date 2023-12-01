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

    func insertData(firstname: String) {
        guard let url = URL(string: "https://flashchatcollageproject.000webhostapp.com/Insert_API.php") else { return }
        let parameters: [String: Any] = [
            "firsnname": firstname,
            "username": "ravi",
            "lastname": "Jack & Jill",
            "email": "ritk@email.com",
            "phone":"90897939",
            "password":"ritik"
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


