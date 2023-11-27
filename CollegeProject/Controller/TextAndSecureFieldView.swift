//
//  TextAndSecureFieldView.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 27/11/23.
//

import Foundation
import SwiftUI

struct TextFieldView: View {
    
    @Binding var fieldData: String
    var placeholderText: String
    
    var body: some View {
        VStack(spacing: -5){
            TextField(text: $fieldData) {
                Text(placeholderText)
                    .font(.title3)
                    .foregroundColor(.black)
                    .bold()
            }
            .frame(width: 300, height: 50)
            
            Rectangle()
                .frame(width: 300, height: 1)
        }
    }
}

struct SecureFieldView: View {
    
    @Binding var fieldData: String
    var placeholderText: String
    
    var body: some View {
        VStack(spacing: -5){
            SecureField(text: $fieldData) {
                Text(placeholderText)
                    .font(.title3)
                    .foregroundColor(.black)
                    .bold()
            }
            .frame(width: 300, height: 50)
            
            Rectangle()
                .frame(width: 300, height: 1)
        }
    }
}
