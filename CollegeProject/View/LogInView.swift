//
//  LogInView.swift
//  CollegeProject
//
//  Created by karishma on 15/11/23.
//

import SwiftUI

struct LogInView: View {
    @ObservedObject var fetchData = FetchData()
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var profilePicture: String = "person.circle"
    @State private var showAlert = false
    @State private var loginSuccess = false
    @State private var isLoggedIn = false
    @State private var displayUser = ""
    @State private var alerTitle = ""
    @State private var emojiRotationAngle: Double = 0

    var body: some View {
        ZStack {
            BackGroundView()

            VStack {
                HStack {
                    Text("Log in")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal, 40)
                        .padding(.bottom, 60)
                    Spacer()
                }

                VStack {
                    AnimatedEmojiView(isPasswordEntered: !password.isEmpty, isUsernameEntered: !userName.isEmpty, rotationAngle: $emojiRotationAngle)
                        .frame(width: 100, height: 100)

                    Text("Enter Your Details")
                        .font(.title2)
                }
                .padding(.bottom, 100)

                Text(alerTitle)

                VStack(alignment: .leading, spacing: 20) {
                    TextFieldView(fieldData: $userName, placeholderText: "User Name...")
                        .onChange(of: userName) { newValue in
                            // Set isUsernameEntered based on your logic
                            // Example: isUsernameEntered = !newValue.isEmpty
                            withAnimation {
                                emojiRotationAngle = newValue.isEmpty ? 15 : -15
                            }
                        }

                    SecureFieldView(fieldData: $password, placeholderText: "Password...")
                        .onChange(of: password) { newValue in
                            // Set isPasswordEntered based on your logic
                            // Example: isPasswordEntered = !newValue.isEmpty
                            withAnimation {
                                emojiRotationAngle = newValue.isEmpty ? 15 : 0
                            }
                        }

                    Button {
                        handleLogin()
                    } label: {
                        Text("Log in")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 300, height: 50)
                            .background(.black)
                            .cornerRadius(30)
                    }

                    NavigationLink(
                        destination: UserView(),
                        isActive: $isLoggedIn,
                        label: { EmptyView() }
                    )
                    .opacity(0)
                    .disabled(true)
                }
                .frame(width: 350, height: 250)
                .background(.opacity(0.3))
                .cornerRadius(20)
                .padding(.bottom, 30)
            }
            .alert(isPresented: $showAlert) {
                getAlert()
            }
        }
    }

    struct AnimatedEmojiView: View {
        var isPasswordEntered: Bool
        var isUsernameEntered: Bool
        @Binding var rotationAngle: Double

        var body: some View {
            Image(systemName: "😊")
                .resizable()
                .scaledToFit()
                .font(Font.title.weight(.ultraLight))
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(rotationAngle))
                .animation(.easeInOut(duration: 0.5), value: isPasswordEntered || isUsernameEntered)
                .onAppear {
                    // Start with the emoji looking down
                    rotationAngle = 15
                }
        }
    }

    func getAlert() -> Alert {
        return Alert(title: Text(alerTitle))
    }

    func handleLogin() {
        // Fetch data from the API
        FetchDataModel.fetchData { result in
            switch result {
            case .success(let users):
                // Compare user input with fetched user data
                if let matchedUser = users.first(where: { $0.username == userName && $0.password == password }) {
                    // Login successful
                    print("Login successful for user: \(matchedUser.username)")
                    isLoggedIn = true
                } else {
                    // Login failed
                    print("Invalid credentials")
                    isLoggedIn = false
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
