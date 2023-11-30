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
