//import SwiftUI
//import Contacts
//
//struct ContactComparisonView: View {
//    @State private var databaseContactNumber = "1234567890" // Replace this with your database contact number
//    @State private var comparisonResult = ComparisonResult.unknown
//
//    enum ComparisonResult {
//        case unknown
//        case matching
//        case notMatching
//    }
//
//    var body: some View {
//        VStack {
//            Text("Database Contact Number: \(databaseContactNumber)")
//
//            Button("Check Contact") {
//                checkContact()
//            }
//
//            if comparisonResult == .matching {
//                Text("Contact matched!")
//            } else if comparisonResult == .notMatching {
//                Text("Contact did not match.")
//            } else {
//                Text("Press 'Check Contact' to compare.")
//            }
//        }
//    }
//
//    func checkContact() {
//        let store = CNContactStore()
//        store.requestAccess(for: .contacts) { granted, error in
//            if granted {
//                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
//                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
//
//                do {
//                    var contactMatched = false
//                    try store.enumerateContacts(with: request) { contact, _ in
//                        for phoneNumber in contact.phoneNumbers {
//                            if let userContactNumber = phoneNumber.value.stringValue,
//                               userContactNumber == databaseContactNumber {
//                                contactMatched = true
//                                break
//                            }
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        self.comparisonResult = contactMatched ? .matching : .notMatching
//                    }
//                } catch {
//                    print("Error fetching contacts: \(error)")
//                }
//            } else {
//                print("Access to contacts not granted")
//            }
//        }
//    }
//}
//
//struct ContactView: View {
//    var body: some View {
//        ContactComparisonView()
//    }
//}
