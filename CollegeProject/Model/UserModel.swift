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
    @Published var isBlock = false
    
    func registerUser(){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let e = error{
                print(e)
            } else {
                let reference = Database.database().reference()
<<<<<<< HEAD
               
                reference.child("users").child((authResult?.user.uid)!).setValue(["FirstName": self.firstName, "LastName": self.lastName, "PhoneNumber": self.contactNumber, "isBlock": self.isBlock])
=======
                
                reference.child("users").child((authResult?.user.uid)!).setValue(["FirstName": self.firstName, "LastName": self.lastName, "PhoneNumber": self.contactNumber])
>>>>>>> 46297727696152aa3ff7b164f3476b074583cf15
                
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
    @Published var AdminLogin = false
    
    func loginUser() {
        if email == "" && password == "" {
            showingAlert = true
        } else if email == "admin@gmail.com" && password == "123456" {
            AdminLogin = true
        } else {
            AdminLogin = false
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

func sendData(user : UsersData, message : String, imageUrl : String? = nil){
    let reference = Database.database().reference().child("messages")
    
    let childRef = reference.childByAutoId()
    
    let toId = user.userId
    
    let fromId = Auth.auth().currentUser!.uid
    
    let timeStamp = Int(NSDate().timeIntervalSince1970)
    
    var values = ["text":message, "toId":toId, "fromId":fromId,"timestamp":timeStamp] as [String : Any]
    
    if let imageUrl = imageUrl { values["imageUrl"] = imageUrl }
    
    childRef.updateChildValues(values) { (error, ref) in
        
        if let error = error{
            
            print(error.localizedDescription)
            
        }else{
            
            let userMessagesRef = Database.database().reference().child("user-messages").child(fromId)
            
            let messageId = childRef.key!
            
            userMessagesRef.updateChildValues([messageId:"a"])
            
            let recipientUserMessagesReference = Database.database().reference().child("user-messages").child(toId )
            
            recipientUserMessagesReference.updateChildValues([messageId:"a"])
        }
    }
}
