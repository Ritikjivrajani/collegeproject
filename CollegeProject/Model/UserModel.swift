import Foundation
import FirebaseAuth
import FirebaseDatabaseInternal
import Firebase

class register: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var contactNumber: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var registerSuccess = false
    
    func registerUser(){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let e = error{
                print(e)
            } else {
                let reference = Database.database().reference()
                
                reference.child("users").child((authResult?.user.uid)!).setValue(["FirstName": self.firstName, "LastName": self.lastName, "PhoneNumber": self.contactNumber])
                
                self.registerSuccess = true
            }
        }
    }
}

class Login: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showingAlert = false
    @Published var LoginSuccess = false
    
    func loginUser() {
        if email == "" && password == "" {
            showingAlert = true
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
            } else {
                print("Login success...")
                self.LoginSuccess = true
            }
        }
    }
}

struct UsersData: Hashable {
    var firstName: String
    var lastName: String
    var userId: String
}

class FirebaseService: ObservableObject {
    @Published var items: [UsersData] = []
    
    init() {
        fetchData()
    }
    func fetchData() {
        
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = UsersData(
                    firstName: (dictionary["FirstName"] as! String),
                    lastName: (dictionary["LastName"] as! String),
                    userId: snapshot.key)
                self.items.append(user)
            }
        }, withCancel: nil)
    }
}

extension DataSnapshot {
    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        let data = try JSONSerialization.data(withJSONObject: value!)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
