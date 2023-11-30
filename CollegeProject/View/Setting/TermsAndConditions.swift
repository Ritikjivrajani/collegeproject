//
//  TermsAndConditions.swift
//  CollegeProject
//
//  Created by Ritik Jivrajani on 26/11/23.
//

import SwiftUI

struct TermsAndConditions: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Terms and Conditions of Use for Flash Chat")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 16)
                
                Text("""
1. **Acceptance of Terms**

By accessing or using the Flash Chat application ("the App"), you agree to comply with and be bound by these terms and conditions ("Terms"). If you do not agree to these Terms, please do not use the App.

2. **User Accounts**

2.1 You must be at least 13 years old to use Flash Chat. By using the App, you confirm that you meet this age requirement.

2.2 You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.

3. **User Content**

3.1 Flash Chat allows users to create, post, and share content. By using the App, you grant Flash Chat a worldwide, non-exclusive, royalty-free license to use, reproduce, modify, distribute, and display your content.

3.2 You agree not to post or transmit content that is unlawful, threatening, abusive, defamatory, infringing on intellectual property rights, or otherwise objectionable.

4. **Privacy and Data Security**

4.1 Flash Chat is committed to protecting your privacy. Our Privacy Policy outlines how we collect, use, and disclose personal information. By using the App, you consent to the terms of the Privacy Policy.

4.2 You are responsible for keeping your personal information accurate and up-to-date.

5. **Prohibited Activities**

5.1 You agree not to engage in any activities that may harm, disrupt, or impair the functionality of Flash Chat or its users.

5.2 Prohibited activities include but are not limited to: distributing malware, attempting to gain unauthorized access to accounts, and engaging in any form of harassment.

6. **Termination**

Flash Chat reserves the right to suspend or terminate your account, at its sole discretion, for any reason, including violations of these Terms.

7. **Changes to Terms**

Flash Chat may update these Terms at any time. Your continued use of the App after the posting of changes constitutes your acceptance of such changes.

8. **Limitation of Liability**

8.1 Flash Chat is provided "as is" without any warranties.

8.2 Flash Chat is not liable for any indirect, incidental, special, consequential, or punitive damages arising out of or related to your use of the App.

9. **Governing Law**

These Terms are governed by and construed in accordance with the laws of [Your Jurisdiction]. Any legal actions arising out of or in connection with these Terms shall be brought exclusively in the state or federal courts located in [Your Jurisdiction].

10. **Contact Information**

If you have any questions or concerns regarding these Terms, please contact us at [Your Contact Information].
""")
                .multilineTextAlignment(.leading)
            }
            .padding()
            .background(Color.white) // Set background color
            .cornerRadius(15) // Add corner radius
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth: 1) // Add border
            )
            .padding() // Padding for the border and background
        }
        .navigationTitle("Terms and Conditions")
    }
}

struct TermsAndConditions_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditions()
    }
}
