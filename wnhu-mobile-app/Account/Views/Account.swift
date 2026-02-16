//
//  Account.swift
//  wnhu-mobile
//
//  Created by Sarah Svitlik on 12/23/25.
//

import SwiftUI

struct Account: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var appVariables: AppVariables

    var fullName: String { "\(userData.user.firstName) \(userData.user.lastName)" }
    
    @State private var isPopoverShowing = false 
    
    var body: some View {
        VStack {
            // Profile pic
            Image(systemName: "person.circle.fill")
                .resizable()
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 0.98, green: 0.25, blue: 0.25),
                            Color(red: 0.60, green: 0.00, blue: 0.00)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .scaledToFit()
                .frame(width: 150)
                .foregroundColor(.white)
                .shadow(radius: 8)
                .padding(.top, 30)
            
            
            Text(fullName)
                .padding(.top, 5)
                .font(.title3.weight(.medium))
                .padding(.bottom, 1)
            Text(userData.user.email)
                .padding(.bottom, 10)
                .foregroundColor(.secondary)
            
            Divider()
                .frame(height: 1)
                .background(Color.white.opacity(0.3))
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            
            HStack {
                Button( action: {
                    isPopoverShowing.toggle()
                }){
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .padding(.trailing, 20 )
                        .padding(.leading, 25 )
                    Text("Liked Songs")
                        .font(.system(size: 22))
                        .foregroundStyle(Color.white)
                }
                .popover(isPresented: $isPopoverShowing) {
                    VStack {
                        Text("Liked Songs")
                            .font(.system(size: 22))
                        ForEach(userData.songs, id: \.id) { song in
                            HStack {
                                Image(systemName: "music.note")
                                    .padding(.leading, 30 )

                                Text(song.songName)
                                Text("-")
                                Text(song.artistName)
                            }
                            .frame(maxWidth: 375, maxHeight: 100, alignment: .leading)

                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color.white.opacity(0.06))
                            )
                        }
                    }
                }
                .frame(maxWidth: 350, maxHeight: 100, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                )
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Account Settings")
                    .font(.system(size: 22))
                    .padding(.bottom, 4)

                Button("Logout") {
                    logout()
                }
                .foregroundColor(.red.opacity(0.8))
                .font(.system(size: 16))
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 20)
            .frame(maxWidth: 350, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white.opacity(0.06))
            )

        } .padding(.bottom, 100)
    }
    
    private func logout() {
        guard let url = URL(string: "http://127.0.0.1:3000/logoutMobile") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{}".data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Logout failed: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                appVariables.isLoggedIn = false
                appVariables.showLoginPage = true
                userData.user.firstName = ""
                userData.user.lastName = ""
                userData.user.email = ""
            }
        }.resume()
    }
}

#Preview {
    Account()
        .environmentObject(UserData())
        .environmentObject(AppVariables())
}

