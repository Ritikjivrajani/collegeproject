//
//  ContactModel.swift
//  CollegeProject
//
//  Created by karishma on 26/11/23.
//

import Foundation
import Contacts

func fetchSpecificContact(){
    let store = CNContactStore()
    
    let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
    
    let predicate = CNContact.predicateForContacts(matchingName: "Kate")
    
    do{
        let contact = try store.unifiedContacts(matching: predicate, keysToFetch: keys)
        print(contact)
    }
    catch{
        
    }
}
