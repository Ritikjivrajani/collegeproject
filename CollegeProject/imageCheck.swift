//
//  imageCheck.swift
//  CollegeProject
//
//  Created by karishma on 11/01/24.
//

import SwiftUI

struct imageCheck: View {
    var body: some View {
        HStack{
            Image(systemName: "person.fill")
                .data(url: URL(string: "/Users/karishma/Library/Developer/CoreSimulator/Devices/DA516623-182B-47F7-BF66-4E8C90C9E246/data/Containers/Data/Application/998A9EFD-6DDC-4025-ACE0-7026AB57AAB2/Documents/selectedImage.jpg")!)
            
//                ima
        }
    }
}

extension Image{
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url){
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}

#Preview {
    imageCheck()
}
