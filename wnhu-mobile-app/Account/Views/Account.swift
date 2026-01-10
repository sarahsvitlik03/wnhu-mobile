//
//  Account.swift
//  wnhu-mobile
//
//  Created by Sarah Svitlik on 12/23/25.
//

import SwiftUI

struct Account: View {
    @EnvironmentObject var userData: UserData

    var fullName: String { "\(userData.user.firstName) \(userData.user.lastName)" }
    
    @State private var isPopoverShowing = false 
    
    var body: some View {
        VStack {
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
                .frame(maxWidth: 375, maxHeight: 100, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                )
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Account Settings")
                    .font(.system(size: 22))
                    .padding(.bottom, 4)

                Text("Change username")
                    .font(.system(size: 16))

                Text("Change password")
                    .font(.system(size: 16))

                Text("Logout")
                    .font(.system(size: 16))
                    .foregroundColor(.red.opacity(0.8))
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 20)
            .frame(maxWidth: 375, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white.opacity(0.06))
            )

        } .padding(.bottom, 100)
    }
}

#Preview {
    Account()
        .environmentObject(UserData())
}


/* Notes for next time
 *
 *   Circle at the top with picture of a person, name + unh email
 *   Make json data to pull from
 *   Have name, email, again
 *   Have liked songs be a pop up
 *   Account settings section
 *       Change name
 *       Change password
 *       Log out
 *
 *
 
 */


